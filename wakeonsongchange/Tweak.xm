#define BUNDLEID "com.ruler225.peekatunes"

bool lowPowerEnabled;
bool enabledInLPM;

//Create interfaces for the classes with the methods we need
@interface SpringBoard
-(void)_simulateHomeButtonPress;
@end

@interface SBDashBoardViewController
-(bool)isInScreenOffMode;
@end

@interface SBLockScreenViewController
-(bool)isInScreenOffMode;
@end


//Pointers to the classes for which we need to access private methods
SpringBoard *SBCopy;
SBDashBoardViewController *SBLockCopy;
SBLockScreenViewController *SBLockCopy9;


%hook SpringBoard
-(id)init{
	SBCopy = self; //Create a pointer to SpringBoard so that we can access its private methods
	return %orig;
}

//Save low power mode’s state in a boolean
-(bool)isBatterySaverModeActive{
	lowPowerEnabled = %orig;
	return lowPowerEnabled;
}
%end

%group iOS10

%hook SBDashBoardViewController

-(void)viewDidLoad{
	%orig;
	SBLockCopy = self;	//Create a pointer to SBDashboardViewController so that we can access its private methods
}

%end

%hook SBMediaController
-(void)_nowPlayingInfoChanged{
	//make sure low power mode is off before checking the rest. Because that’s the kind of smart programmer I am :P
	if(!lowPowerEnabled || enabledInLPM){
		if([SBLockCopy isInScreenOffMode])
			[SBCopy _simulateHomeButtonPress];	//Simulate home button press to turn on the screen
	%orig;
	}
}

%end

%end

%group iOS9

%hook SBLockScreenViewController

-(void)viewDidLoad{
%orig;
SBLockCopy9 = self;	//Create a pointer to SBLockScreenViewController so that we can access its private methods
}

%end

%hook SBMediaController
-(void)_nowPlayingInfoChanged{
//make sure low power mode is off before checking the rest. Because that’s the kind of smart programmer I am :P
if(!lowPowerEnabled || enabledInLPM){
if([SBLockCopy9 isInScreenOffMode])
[SBCopy _simulateHomeButtonPress];	//Simulate home button press to turn on the screen
%orig;
}
}

%end

%end

%ctor {
		bool tweakEnabled;
    CFPreferencesAppSynchronize(CFSTR(BUNDLEID));
    CFPropertyListRef enabled = CFPreferencesCopyAppValue(CFSTR("Enabled"), CFSTR(BUNDLEID));
    CFPropertyListRef LPMEnabled= CFPreferencesCopyAppValue(CFSTR("EnabledLPM"), CFSTR(BUNDLEID));

		if(enabled == nil)
			tweakEnabled = true;
		else
			tweakEnabled = [CFBridgingRelease(enabled) boolValue];

		if(LPMEnabled == nil)
			enabledInLPM = false;
		else
			enabledInLPM = [CFBridgingRelease(LPMEnabled) boolValue];

    if(tweakEnabled) {
        if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_3)
            %init(iOS10);
        else
            %init(iOS9);

        %init(_ungrouped);
}
}
