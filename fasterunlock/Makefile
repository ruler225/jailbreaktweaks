include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FasterUnlock
FasterUnlock_FILES = Tweak.xm
FasterUnlock_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
