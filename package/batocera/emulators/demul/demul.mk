################################################################################
#
# demul
#
################################################################################

# version: DEmul x86 v0.7 BUILD 280418 - closed source
# not developed since 2018
DEMUL_SOURCE = demul07_280418.7z
DEMUL_SITE = http://demul.emulation64.com/files
DEMUL_DEPENDENCIES = p7zip

define DEMUL_EXTRACT_CMDS
	mkdir -p $(@D) && cd $(@D) && $(TARGET_DIR)/usr/bin/7zr x -y $(DL_DIR)/$(DEMUL_DL_SUBDIR)/$(DEMUL_SOURCE)
endef

define DEMUL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr
	cp -pr $(@D) $(TARGET_DIR)/usr/demul

    # copy english faq & evmap config
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/emulators/demul/faq_en.txt $(TARGET_DIR)/usr/demul/
	mkdir -p $(TARGET_DIR)/usr/share/evmapy
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/emulators/demul/*.keys $(TARGET_DIR)/usr/share/evmapy
endef

$(eval $(generic-package))
