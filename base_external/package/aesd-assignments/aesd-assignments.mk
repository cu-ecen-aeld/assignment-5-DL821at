##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = 48635402cd5638c5374f410da35da328b40673f0
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-DL821at.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# Build both finder-app and server (assuming both are part of the aesd-assignments package)
define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

# Install the aesdsocket binary, start-stop script, and finder-app configurations
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Install the compiled aesdsocket binary to /usr/bin on the target
	$(INSTALL) -D -m 755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket

	# Install the aesdsocket-start-stop script to /etc/init.d/S99aesdsocket on the target
	$(INSTALL) -D -m 755 $(@D)/server/aesdsocket-start-stop.sh $(TARGET_DIR)/etc/init.d/S99aesdsocket

	# Install the finder-app configuration files and scripts
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/* $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))