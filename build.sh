#!/bin/bash
# Script to build Buildroot configuration and then build the full system
# Author: Siddhant Jajoo

source shared.sh

# Set the external layer path.
EXTERNAL_REL_BUILDROOT=../base_external
if [ "$CI" = "true" ]; then
    echo "CI environment detected: Overriding external buildroot path."
    EXTERNAL_REL_BUILDROOT="${GITHUB_WORKSPACE}/base_external"
fi

git submodule init
git submodule sync
git submodule update

set -e
cd "$(dirname "$0")"

# In CI, force regeneration by deleting .config
if [ "$CI" = "true" ]; then
    echo "CI environment detected: Removing existing .config"
    rm -f buildroot/.config
fi

# If no configuration file exists, use defconfig to create one.
if [ ! -e buildroot/.config ]; then
    echo "MISSING BUILDROOT CONFIGURATION FILE"
    if [ -e "${AESD_MODIFIED_DEFCONFIG}" ]; then
        echo "USING ${AESD_MODIFIED_DEFCONFIG}"
        make -C buildroot -j$(nproc) defconfig BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} BR2_DEFCONFIG=${AESD_MODIFIED_DEFCONFIG_REL_BUILDROOT}
    else
        echo "Run ./save_config.sh to save this as the default configuration in ${AESD_MODIFIED_DEFCONFIG}"
        echo "Then add packages as needed and re-run ./save_config.sh"
        make -C buildroot -j$(nproc) defconfig BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} BR2_DEFCONFIG=${AESD_DEFAULT_DEFCONFIG}
    fi
else
    echo "USING EXISTING BUILDROOT CONFIG"
    echo "To force update, delete .config or change configuration via make menuconfig."
fi

# Now run the full Buildroot build.
echo "Building Buildroot..."
make -C buildroot -j$(nproc) BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT}
