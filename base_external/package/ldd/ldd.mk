
##############################################################
#
# LDD
#
##############################################################

LDD_VERSION = 'b0217c71505cb5fe2bd4b814503e5f815694dbef'
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-davidxvuong.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

LDD_MODULE_SUBDIRS = misc-modules
LDD_MODULE_SUBDIRS += scull
LDD_MODULE_MAKE_OPTS = KERNELDIR=$(LINUX_DIR)

$(eval $(kernel-module))
$(eval $(generic-package))
