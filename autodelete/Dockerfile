ARG BUILD_FROM
FROM $BUILD_FROM

COPY autodelete.sh /run.sh
RUN chmod +x /run.sh
CMD [ "/run.sh" ]
