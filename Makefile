ARCHS = arm64e arm64

export THEOS=/var/theos
THEOS_PACKAGE_SCHEME=rootless

export SDKVERSION = 14.5
 

export iP = 192.168.1.107
export Port = 22
export Pass = alpine
export Bundle = com.apple.Preferences

DEBUG = 0

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = KeyboardTools

KeyboardTools_FILES = Tweak.xm  
KeyboardTools_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk


install6::
		install6.exec
