ARG BUILD_FROM
FROM $BUILD_FROM

ARG CLIVersion=2.40.0

ENV LANG C.UTF-8

COPY requirements.txt

RUN pip3 --no-cache-dir install -r requirements.txt

# Copy data for add-on
COPY run.sh backup.py /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
