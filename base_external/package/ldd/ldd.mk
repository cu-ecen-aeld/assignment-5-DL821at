LDD_VERSION = 'd9c8eeb916f4f39658888e92d6c8e05cd437882e'
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-DL821at.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES
LDD_MODULE_SUBDIRS += scull
LDD_MODULE_SUBDIRS += misc-modules

$(eval $(kernel-module))
$(eval $(generic-package))