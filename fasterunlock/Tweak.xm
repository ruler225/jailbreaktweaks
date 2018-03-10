%hook SBHomeHardwareButton

@interface SpringBoard
+(id)sharedApplication;
-(bool)isLocked;
@end

- (bool)_acceleratedSinglePressRecognizerShouldBegin{
    if ([[%c(SpringBoard) sharedApplication] isLocked]) {
        return TRUE;
    }
    return %orig;
}

%end
