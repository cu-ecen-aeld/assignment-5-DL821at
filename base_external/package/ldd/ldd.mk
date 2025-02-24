LDD_VERSION = d9c8eeb916f4f39658888e92d6c8e05cd437882e
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-DL821at.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES
LDD_MODULE_SUBDIRS += scull
LDD_MODULE_SUBDIRS += misc-modules

# Explicitly define the kernel version used by Buildroot.
KERNEL_VER = 6.6.50

define LDD_INSTALL_TARGET_CMDS
	# Create the target directory for external modules.
	mkdir -p $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/updates
	$(INSTALL) -D -m 0644 $(BUILD_DIR)/scull/scull.ko $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/updates/scull.ko
	$(INSTALL) -D -m 0644 $(BUILD_DIR)/misc-modules/hello.ko $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/updates/hello.ko
	$(INSTALL) -D -m 0644 $(BUILD_DIR)/misc-modules/faulty.ko $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/updates/faulty.ko

	# Create a minimal modules.dep file so that modprobe can locate these modules.
	echo "/lib/modules/$(KERNEL_VER)/updates/hello.ko:" > $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/modules.dep
	echo "/lib/modules/$(KERNEL_VER)/updates/scull.ko:" >> $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/modules.dep
	echo "/lib/modules/$(KERNEL_VER)/updates/faulty.ko:" >> $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/modules.dep
endef

$(eval $(kernel-module))
$(eval $(generic-package))
