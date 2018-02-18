include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VideoHUD
VideoHUD_FILES = Tweak.xm
VideoHUD_FRAMEWORKS = AVKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
