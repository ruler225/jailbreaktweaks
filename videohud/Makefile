#TARGET = simulator:clang::12.0
#ARCHS = x86_64
#DEBUG = 0

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk


TWEAK_NAME = VideoHUD
VideoHUD_FILES = Tweak.xm
VideoHUD_FRAMEWORKS = AVKit

VideoHUD_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
