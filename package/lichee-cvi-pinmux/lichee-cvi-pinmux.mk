################################################################################
#
# lichee-cvi-pinmux
# packaging taken from:
# https://github.com/milkv-duo/duo-buildroot-sdk-v2/tree/develop/buildroot-2024.02/package/cvi-pinmux
#
################################################################################

LICHEE_CVI_PINMUX_VERSION = 1.0.0
LICHEE_CVI_PINMUX_SITE = $(call github,milkv-duo,cvi-pinmux,$(LICHEE_CVI_PINMUX_VERSION))
LICHEE_CVI_PINMUX_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_LICHEE_CVI_PINMUX_CV180X),y)
	LICHEE_CVI_SRC_DIR = cv180x
else ifeq ($(BR2_PACKAGE_LICHEE_CVI_PINMUX_SG200X),y)
	LICHEE_CVI_SRC_DIR = sg200x
else ifeq ($(BR2_PACKAGE_LICHEE_CVI_PINMUX),y)
	$(error "Please select either CV180X or SG200X")
endif

define LICHEE_CVI_PINMUX_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		$(@D)/$(LICHEE_CVI_SRC_DIR)/*.c -o $(@D)/cvi-pinmux
endef

define LICHEE_CVI_PINMUX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/cvi-pinmux $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
