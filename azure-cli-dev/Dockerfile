ARG BUILD_FROM
FROM $BUILD_FROM

ARG CLIVersion=2.40.0

ENV LANG C.UTF-8

RUN \
  apk update && \
  apk add python3 bash py3-pip && \
  apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make cargo && \
  pip3 install --upgrade pip && \
  pip3 --no-cache-dir install azure-cli==$CLIVersion && \
  apk del --purge build


# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
