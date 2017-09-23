#TARGET = simulator:clang
#ARCHS = x86_64 i386

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WakeTunes
WakeTunes_FILES = Tweak.xm
WakeTunes_PRIVATE_FRAMEWORKS = MediaRemote
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
