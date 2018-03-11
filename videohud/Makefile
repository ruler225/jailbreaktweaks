
#TARGET = simulator:clang::5.0
#ARCHS = x86_64 i386
#DEBUG = 0

include $(THEOS)/makefiles/common.mk


TWEAK_NAME = VideoHUD
VideoHUD_FILES = Tweak.xm
VideoHUD_FRAMEWORKS = AVKit

VideoHUD_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
