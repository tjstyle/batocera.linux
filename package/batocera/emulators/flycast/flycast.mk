################################################################################
#
# flycast
#
################################################################################
# Version: Commits on Jun 24, 2022
FLYCAST_VERSION = 907131b7f5c51fa1cdcf453a900e41c999504a25
FLYCAST_SITE = https://github.com/flyinghead/flycast.git
FLYCAST_SITE_METHOD=git
FLYCAST_GIT_SUBMODULES=YES
FLYCAST_LICENSE = GPLv2
FLYCAST_DEPENDENCIES = sdl2 libpng libzip libao pulseaudio-utils

FLYCAST_CONF_OPTS += -DLIBRETRO=OFF

# determine the best OpenGL version to use
ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
  # Batocera - SBC prefer GLES
  ifneq ($(BR2_PACKAGE_BATOCERA_SBC_XORG),y)
    FLYCAST_CONF_OPTS += -DUSE_OPENGL=ON
  else
    FLYCAST_CONF_OPTS += -DUSE_GLES=ON -DUSE_GLES2=OFF
  endif
else ifeq ($(BR2_PACKAGE_BATOCERA_GLES3),y)
    FLYCAST_CONF_OPTS += -DUSE_GLES=ON -DUSE_GLES2=OFF
else ifeq ($(BR2_PACKAGE_BATOCERA_GLES2),y)
    FLYCAST_CONF_OPTS += -DUSE_GLES2=ON -DUSE_GLES=OFF
endif

ifeq ($(BR2_PACKAGE_BATOCERA_VULKAN),y)
    FLYCAST_CONF_OPTS += -DUSE_VULKAN=ON
else
    FLYCAST_CONF_OPTS += -DUSE_VULKAN=OFF
endif

# RPI: use the legacy Broadcom GLES libraries
ifeq ($(BR2_PACKAGE_BATOCERA_RPI_VCORE),y)
    FLYCAST_CONF_OPTS += -DUSE_VIDEOCORE=ON
endif

define FLYCAST_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/flycast $(TARGET_DIR)/usr/bin/flycast
	# evmapy files
	mkdir -p $(TARGET_DIR)/usr/share/evmapy
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/emulators/flycast/*.keys $(TARGET_DIR)/usr/share/evmapy
endef

$(eval $(cmake-package))
