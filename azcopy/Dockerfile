# Adapted from https://github.com/PeterDaveHello/docker-azcopy
ARG AZCOPY_VERSION=10.17.0
ARG GO_VERSION=1.18
ARG ALPINE_VERSION=3.16
ARG BUILD_ARCH
ARG BUILD_FROM

FROM golang:$GO_VERSION-alpine$ALPINE_VERSION as build
ENV GOARCH=$BUILD_ARCH GOOS=linux
WORKDIR /azcopy
ARG AZCOPY_VERSION
RUN wget -q "https://github.com/Azure/azure-storage-azcopy/archive/v$AZCOPY_VERSION.tar.gz" -O src.tgz
RUN tar xf src.tgz --strip 1 \
 && go build -o azcopy \
 && ./azcopy --version

# Build image from Hassio base image
FROM $BUILD_FROM as release

ENV LANG C.UTF-8

COPY --from=build /azcopy/azcopy /usr/local/bin
WORKDIR /WORKDIR


# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
