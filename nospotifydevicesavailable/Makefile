include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoSpotifyDevicesAvailable
NoSpotifyDevicesAvailable_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall Spotify; killall -9 SpringBoard"
