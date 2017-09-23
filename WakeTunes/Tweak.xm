#define BUNDLEID "com.ruler225.waketunes"
#import "MediaRemote.h"

bool lowPowerEnabled;
bool enabledInLPM;
bool trackChanged;
bool deviceLocked;
bool iOS10;
NSString *currentTitle = @"";
NSString *currentArtist = @"";
NSString *currentAlbum = @"";


//Create interfaces for the classes with the methods we need
@interface SBNCScreenController
-(void)_turnOnScreen;
@end

@interface SBUserAgent
+(id)sharedUserAgent;
-(void)undimScreen;
@end

SBNCScreenController *screenref;

%group iOS10

%hook SBNCScreenController
- (id)initWithBackLightController:(id)arg1 lockScreenManager:(id)arg2 lockStateAggregator:(id)arg3 quietModeStateAggregator:(id)arg4{
	screenref = self;
	return %orig;
}

%end

%end

%hook SpringBoard
//Save low power mode’s state in a boolean
-(bool)isBatterySaverModeActive{
	lowPowerEnabled = %orig;
	return lowPowerEnabled;
}

-(bool)isLocked{
	deviceLocked = %orig;
	return deviceLocked;
}

%end

%hook SBMediaController

-(void)_nowPlayingInfoChanged{
	%orig;
	//make sure low power mode is off before checking the rest. Because that’s the kind of smart programmer I am :P
	if(!lowPowerEnabled || enabledInLPM){
		MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef nowPlayingInfo) {
			if(nowPlayingInfo != nil) {
				NSDictionary *info = (NSDictionary *)(nowPlayingInfo);
				NSString *newNowPlayingTitle;
				NSString *newNowPlayingAlbum;
				NSString *newNowPlayingArtist;
				if([info objectForKey:(NSString *)kMRMediaRemoteNowPlayingInfoTitle] != nil)
				newNowPlayingTitle = [[NSString alloc] initWithString:[info objectForKey:(NSString *)kMRMediaRemoteNowPlayingInfoTitle]];
				else
				newNowPlayingTitle = @"";
				if([info objectForKey:(NSString *)kMRMediaRemoteNowPlayingInfoAlbum] != nil)
				newNowPlayingAlbum = [[NSString alloc] initWithString:[info objectForKey:(NSString *)kMRMediaRemoteNowPlayingInfoAlbum]];
				else
				newNowPlayingAlbum = @"";
				if([info objectForKey:(NSString *)kMRMediaRemoteNowPlayingInfoArtist] != nil)
				newNowPlayingArtist = [[NSString alloc] initWithString:[info objectForKey:(NSString *)kMRMediaRemoteNowPlayingInfoArtist]];
				else
				newNowPlayingArtist = @"";

				//These lines can be uncommented for debugging purposes. Use oslog to view output
/*
				HBLogDebug(@"Old song: %@ | New song: %@", currentTitle, newNowPlayingTitle);
				HBLogDebug(@"Old album: %@ | New album: %@", currentAlbum, newNowPlayingAlbum);
				HBLogDebug(@"Old artist: %@ | New artist: %@", currentArtist, newNowPlayingArtist);
*/
				if (![currentTitle isEqual:newNowPlayingTitle]) {
					trackChanged = true;
					currentTitle = newNowPlayingTitle;
				}
				if (![currentAlbum isEqual:newNowPlayingAlbum]){
					trackChanged = true;
					currentAlbum = newNowPlayingAlbum;
				}
				if (![currentArtist isEqual:newNowPlayingArtist]) {
					trackChanged = true;
					currentArtist = newNowPlayingArtist;
				}

			}

			//HBLogDebug(@"Screen should turn on now: %@", (trackChanged ? @"Yes" : @"no"));
			if (trackChanged && deviceLocked) {
				if(iOS10)
					[screenref _turnOnScreen];
				else
					[((SBUserAgent *)[%c(SBUserAgent) sharedUserAgent]) undimScreen];
				}
			trackChanged = false;


		});
	}
}



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


	if(tweakEnabled)
		%init(_ungrouped);
		if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_3){
			iOS10 = true;
			%init(iOS10);
		}
		else
			iOS10 = false;
}
