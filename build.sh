#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

KERNEL_VERSION="${KERNEL_VERSION:-4.18.0-553.8.1.el8_10.x86_64}"
NVIDIA_DRIVER_VERSION="${NVIDIA_DRIVER_VERSION:-550.54.14}"
CONTAINER_REGISTRY="${CONTAINER_REGISTRY:-registry.pulsepoint.com}"
# TODO - pin OS releases to their vault URLs like https://dl.rockylinux.org/vault/rocky/8.8, maybe parameterize packages in install script too
RPM_BASE_URL="${RPM_BASE_URL:-https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages}"
OS_NAME="${OS_NAME:-rocky}"
OS_RELEASE="${OS_RELEASE:-8.9}"

echo "Building NVIDIA Driver image version $NVIDIA_DRIVER_VERSION for ${OS_NAME}${OS_RELEASE} (kernel version $KERNEL_VERSION)\
 and deploying to registry $CONTAINER_REGISTRY, pulling kernel RPMs from base URL $RPM_BASE_URL"

docker build -t "$CONTAINER_REGISTRY/nvidia/driver:$NVIDIA_DRIVER_VERSION-${OS_NAME}${OS_RELEASE}" \
     --build-arg "NVIDIA_DRIVER_VERSION=$NVIDIA_DRIVER_VERSION" \
     --build-arg "RPM_BASE_URL=$RPM_BASE_URL" \
     --build-arg "OS_RELEASE=$OS_RELEASE" \
     -f Dockerfile .
docker push $CONTAINER_REGISTRY/nvidia/driver:$NVIDIA_DRIVER_VERSION-${OS_NAME}${OS_RELEASE}
