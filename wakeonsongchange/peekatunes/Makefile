include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = peekatunes
peekatunes_FILES = XXXRootListController.m
peekatunes_INSTALL_PATH = /Library/PreferenceBundles
peekatunes_FRAMEWORKS = UIKit
peekatunes_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/peekatunes.plist$(ECHO_END)
