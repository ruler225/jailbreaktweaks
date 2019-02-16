#TARGET = simulator:clang::12.0
#ARCHS = x86_64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TerribleHUD
TerribleHUD_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
