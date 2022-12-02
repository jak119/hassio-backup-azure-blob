import os
from azure.storage.blob import BlobServiceClient, BlobClient
from azure.storage.blob import ContentSettings, ContainerClient

# Get variables from the OS
CONNECTION_STRING = os.getenv('CONNECTION_STRING')
CONTAINER = os.getenv('CONTAINER')

# Make this available for easy changing
SOURCE_PATH = "./backup/"

class AzureBlobFileUploader:
    def __init__(self):
        print("Intializing upload")

        # Initialize the connection to Azure storage account
        self.blob_service_client = BlobServiceClient.from_connection_string(
            CONNECTION_STRING)

        print(f"Connected to {self.blob_service_client.account_name}")

    def upload_all_files_in_folder(self):
        # Get all files in SOURCE_PATH
        all_file_names = [f for f in os.listdir(SOURCE_PATH)
                          if os.path.isfile(os.path.join(SOURCE_PATH, f))]

        # Upload each file
        for file_name in all_file_names:
            self.upload_file(file_name)

    def upload_file(self, file_name):
        # Create blob with same name as local file name
        blob_client = self.blob_service_client.get_blob_client(container=CONTAINER,
                                                               blob=file_name)
        # Get full path to the file
        upload_file_path = os.path.join(SOURCE_PATH, file_name)

        # Create blob on storage
        # Overwrite if it already exists!
        content_setting = ContentSettings(content_type='application/x-tar')
        print(f"Uploading {file_name}")
        with open(upload_file_path, "rb") as data:
            blob_client.upload_blob(
                data, overwrite=True, content_settings=content_setting)


# Initialize class and upload files
azure_blob_file_uploader = AzureBlobFileUploader()
azure_blob_file_uploader.upload_all_files_in_folder()
