LDD_VERSION = d9c8eeb916f4f39658888e92d6c8e05cd437882e
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-DL821at.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES
LDD_MODULE_SUBDIRS += scull
LDD_MODULE_SUBDIRS += misc-modules

define LDD_INSTALL_TARGET_CMDS
	# Ensure the target directory exists
	mkdir -p $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/updates
	$(INSTALL) -D -m 0644 $(BUILD_DIR)/scull/scull.ko $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/updates/scull.ko
	$(INSTALL) -D -m 0644 $(BUILD_DIR)/misc-modules/hello.ko $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/updates/hello.ko
	$(INSTALL) -D -m 0644 $(BUILD_DIR)/misc-modules/faulty.ko $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/updates/faulty.ko

	# Create a minimal modules.dep file so that modprobe can find these modules.
	# This file lists each module with no dependencies.
	echo "/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/updates/hello.ko:" > $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/modules.dep
	echo "/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/updates/scull.ko:" >> $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/modules.dep
	echo "/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/updates/faulty.ko:" >> $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_VERSION)/modules.dep
endef

$(eval $(kernel-module))
$(eval $(generic-package))
