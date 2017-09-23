include $(THEOS)/makefiles/common.mk

TARGET = simulator:clang
ARCHS = x86_64 i386
DEBUG = 0
GO_EASY_ON_ME = 1

TWEAK_NAME = PopupOnStart
PopupOnStart_FILES = Tweak.xm
PopupOnStart_CFLAGS = -fobjc-arc -Wno-deprecated-declarations


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
