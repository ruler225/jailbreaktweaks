include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Peek-a-Tunes
Peek-a-Tunes_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += peekatunes
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
