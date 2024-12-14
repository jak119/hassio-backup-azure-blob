import os
import logging
import sys
import json
import shutil
from datetime import datetime
from typing import Optional, Dict, Any

from azure.storage.blob import BlobServiceClient
from azure.core.exceptions import AzureError
from azure.identity import ClientSecretCredential

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler("/share/ha_azure_backup.log"),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger("ha_azure_backup")

class HABackupSync:
    def __init__(self, config: Dict[str, Any]):
        """Initialize the backup sync tool with configuration."""
        self.config = config
        self.backup_dir = config.get('backup_dir', '/backup')
        self.container_name = config.get('container_name', 'habackups')
        self.delete_after_upload = config.get('delete_after_upload', False)
        
        # Azure authentication setup
        self.account_url = f"https://{config['storage_account']}.blob.core.windows.net"
        
        if 'sas_token' in config:
            self.blob_service = BlobServiceClient(
                account_url=self.account_url,
                credential=config['sas_token']
            )
        else:
            # Use service principal authentication
            credential = ClientSecretCredential(
                tenant_id=config['tenant_id'],
                client_id=config['client_id'],
                client_secret=config['client_secret']
            )
            self.blob_service = BlobServiceClient(
                account_url=self.account_url,
                credential=credential
            )

    def ensure_container_exists(self) -> None:
        """Ensure the blob container exists, create if it doesn't."""
        try:
            container_client = self.blob_service.get_container_client(self.container_name)
            if not container_client.exists():
                container_client.create_container()
                logger.info(f"Created container: {self.container_name}")
        except AzureError as e:
            logger.error(f"Failed to ensure container exists: {str(e)}")
            raise

    def list_local_backups(self) -> list:
        """List all backup files in the backup directory."""
        try:
            return [f for f in os.listdir(self.backup_dir) 
                   if f.endswith('.tar') or f.endswith('.zip')]
        except Exception as e:
            logger.error(f"Failed to list local backups: {str(e)}")
            return []

    def upload_backup(self, filename: str) -> bool:
        """Upload a single backup file to Azure Blob Storage."""
        local_path = os.path.join(self.backup_dir, filename)
        
        try:
            blob_client = self.blob_service.get_blob_client(
                container=self.container_name,
                blob=filename
            )
            
            with open(local_path, "rb") as data:
                blob_client.upload_blob(data, overwrite=True)
            
            logger.info(f"Successfully uploaded: {filename}")
            
            if self.delete_after_upload:
                os.remove(local_path)
                logger.info(f"Deleted local backup: {filename}")
            
            return True
            
        except AzureError as e:
            logger.error(f"Failed to upload {filename}: {str(e)}")
            return False
        except Exception as e:
            logger.error(f"Unexpected error uploading {filename}: {str(e)}")
            return False

    def sync_backups(self) -> Dict[str, int]:
        """Synchronize all backups to Azure Blob Storage."""
        results = {
            "successful": 0,
            "failed": 0,
            "total": 0
        }
        
        try:
            self.ensure_container_exists()
            backups = self.list_local_backups()
            results["total"] = len(backups)
            
            for backup in backups:
                if self.upload_backup(backup):
                    results["successful"] += 1
                else:
                    results["failed"] += 1
            
            logger.info(f"Sync completed. Results: {json.dumps(results)}")
            return results
            
        except Exception as e:
            logger.error(f"Sync process failed: {str(e)}")
            return results

def main():
    """Main entry point for the add-on."""
    try:
        with open('/data/options.json', 'r') as options_file:
            config = json.load(options_file)
    except Exception as e:
        logger.error(f"Failed to load configuration: {str(e)}")
        sys.exit(1)

    required_fields = ['storage_account']
    if 'sas_token' not in config and not all(k in config for k in ['tenant_id', 'client_id', 'client_secret']):
        logger.error("Configuration must include either sas_token or service principal credentials")
        sys.exit(1)

    for field in required_fields:
        if field not in config:
            logger.error(f"Missing required configuration field: {field}")
            sys.exit(1)

    sync_tool = HABackupSync(config)
    results = sync_tool.sync_backups()
    
    if results["failed"] > 0:
        sys.exit(1)
    
    sys.exit(0)

if __name__ == "__main__":
    main()