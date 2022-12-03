ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

COPY requirements.txt /tmp

RUN \
  apk update && \
  apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make rust cargo && \
  pip3 install --upgrade pip && \
  pip3 --no-cache-dir install -r /tmp/requirements.txt && \
  apk del --purge build

# Copy data for add-on
COPY run.sh backup.py /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
