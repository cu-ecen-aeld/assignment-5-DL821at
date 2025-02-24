#!/bin/sh
# post-image.sh: Copy external modules into the target filesystem and create a minimal modules.dep

# Define the kernel version explicitly
KERNEL_VER=6.6.50

# Create the updates directory if it doesn't exist
mkdir -p ${TARGET_DIR}/lib/modules/${KERNEL_VER}/updates

# Copy the built module files from the Buildroot build directory into the target
cp -v ${BUILD_DIR}/scull/scull.ko ${TARGET_DIR}/lib/modules/${KERNEL_VER}/updates/
cp -v ${BUILD_DIR}/misc-modules/hello.ko ${TARGET_DIR}/lib/modules/${KERNEL_VER}/updates/
cp -v ${BUILD_DIR}/misc-modules/faulty.ko ${TARGET_DIR}/lib/modules/${KERNEL_VER}/updates/

# Create a minimal modules.dep file listing each module with no dependencies
echo "/lib/modules/${KERNEL_VER}/updates/hello.ko:" > ${TARGET_DIR}/lib/modules/${KERNEL_VER}/modules.dep
echo "/lib/modules/${KERNEL_VER}/updates/scull.ko:" >> ${TARGET_DIR}/lib/modules/${KERNEL_VER}/modules.dep
echo "/lib/modules/${KERNEL_VER}/updates/faulty.ko:" >> ${TARGET_DIR}/lib/modules/${KERNEL_VER}/modules.dep

