#!/bin/sh

dockerd &
sleep 10

# Determine architecture
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then
PLATFORM=linux/arm64
else
PLATFORM=linux/amd64
fi

docker buildx create --name multiplatformEnclave --driver docker-container --bootstrap
docker buildx use multiplatformEnclave

cd /app/mount/setup
docker buildx build --platform $PLATFORM -t enclave:latest --load .

mkdir -p /app/mount/enclave
mkdir -p /var/log/nitro_enclaves
touch /var/log/nitro_enclaves/nitro_enclaves.log

nitro-cli build-enclave --docker-uri enclave:latest --output-file /app/mount/enclave/enclave.eif
