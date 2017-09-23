include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = waketunes
waketunes_FILES = XXXRootListController.m
waketunes_INSTALL_PATH = /Library/PreferenceBundles
waketunes_FRAMEWORKS = UIKit
waketunes_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/waketunes.plist$(ECHO_END)
