##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = cf4031d5a94289985b4f7667cedfcadf311b10b8
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-DL821at.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# Build both finder-app and server (assuming both are part of the aesd-assignments package)
define AESD_ASSIGNMENTS_BUILD_CMDS
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef
# Install the aesdsocket binary, start-stop script, and finder-app configurations
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Install the compiled aesdsocket binary to /usr/bin on the target
	${INSTALL} -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	${INSTALL} -m 0755 $(@D)/server/aesdsocket-start-stop.sh $(TARGET_DIR)/etc/init.d/S99aesdsocket

endef

$(eval $(generic-package))
