%hook SBHomeHardwareButton

- (bool)_acceleratedSinglePressRecognizerShouldBegin{
    if (UIApplication.sharedApplication.isLocked) {
        return TRUE;
    }
    return %orig;
}

%end
