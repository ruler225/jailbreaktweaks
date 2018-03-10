//Create interfaces for the stuff we need
@interface AVVolumeSlider : UISlider
@end

@interface AVStackView : UIStackView
@end

@interface AVBackdropView : AVStackView
@property (nonatomic, assign) AVStackView *contentView;
@end

@interface SBHUDWindow : UIWindow
-(void)_rotateWindowToOrientation:(NSInteger)arg1 updateStatusBar:(bool)arg2 duration:(CGFloat)arg3 skipCallbacks:(bool)arg4;
@end

@interface SpringBoard
-(NSInteger)activeInterfaceOrientation;

@end


AVVolumeSlider *newHUD = nil;
AVBackdropView *backdrop = nil;
UIView *placeholder = nil;
UIView *placeholder2 = nil;
SBHUDWindow *HUDWindow;
SpringBoard *SBRef = nil;

//Get the volume of the ringer
%hook SBRingerHUDView
-(void)setProgress:(float)ringerVolume{
  [newHUD setValue:ringerVolume animated:true];
  %orig;
}
%end

//Change the icon and behaviour of the HUD when the silent switch is flipped
%hook SpringBoard
-(void)_updateRingerState:(int)silentstate withVisuals:(bool)displayVisuals updatePreferenceRegister:(bool)arg3{
  if(displayVisuals){
    if (silentstate == 0){
      [newHUD setMaximumValueImage:[UIImage imageNamed:@"VolumeMuted" inBundle:[NSBundle bundleWithPath:@"/System/Library/Frameworks/AVKit.framework"] compatibleWithTraitCollection:NULL]];
      [newHUD setValue:0 animated:true];
    }
    else
    [newHUD setMaximumValueImage:[UIImage imageNamed:@"VolumeHigh" inBundle:[NSBundle bundleWithPath:@"/System/Library/Frameworks/AVKit.framework"] compatibleWithTraitCollection:NULL]];
  }
  %orig;
}

-(id)init{
  SBRef = %orig;
  return SBRef;
}
%end

//Get the current instance of SBHUDWindow
%hook SBHUDWindow
-(id)initWithScreen:(id)arg1 debugName:(id)arg2{
  HUDWindow = %orig;
  return HUDWindow;
}

-(bool)_shouldAutorotateToInterfaceOrientation:(NSInteger)arg1{
  return true;
}

-(bool)autorotates{
  return true;
}
%end

%hook SBHUDController

//Handle fade out animation once it's time for SBHUDWindow to be dismissed
-(void)_orderWindowOut:(id)arg1{
  [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{backdrop.alpha = 0;} completion:nil];
  %orig;
}

//Fun stuff happens here
-(void)presentHUDView:(UIView*)HUDView autoDismissWithDelay:(CGFloat)delay{
  //try{
  %orig;
  HUDView.hidden = true;  //hide original volume HUD
  CGRect bounds;          //Create dimensions for the volume slider
  CGRect hudFrame;
  CGRect statusBarFrame;
  statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];

  hudFrame.size.width = 162;
  hudFrame.size.height = 47;
  hudFrame.origin.x = ([[UIScreen mainScreen] bounds].size.width - hudFrame.size.width) - 10;
  // Put the hudFrame under the status bar, taking in count that not
  // all iPhones have the same status bar height (ie.: iPhone X) (thanks /u/AkdM_!)
  hudFrame.origin.y = statusBarFrame.size.height + 5;

  if(newHUD == nil) {
    newHUD = [[AVVolumeSlider alloc] initWithFrame:hudFrame];
    backdrop = [[AVBackdropView alloc] initWithFrame:hudFrame];
    backdrop.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    placeholder = [[UIView alloc] initWithFrame:bounds];
    placeholder2 = [[UIView alloc] initWithFrame:bounds];
    [placeholder.widthAnchor constraintEqualToConstant:42].active = true;
    [placeholder2.widthAnchor constraintEqualToConstant:20].active = true;
    backdrop.alpha = 0;

  }
  if(backdrop.alpha != 0)
  [HUDWindow _rotateWindowToOrientation:[SBRef activeInterfaceOrientation] updateStatusBar:false duration:0.5 skipCallbacks:true];
  else
  [HUDWindow _rotateWindowToOrientation:[SBRef activeInterfaceOrientation] updateStatusBar:false duration:0.5 skipCallbacks:true];

  [backdrop setFrame:hudFrame];
  [backdrop.contentView addArrangedSubview:placeholder2];
  [backdrop.contentView addArrangedSubview:newHUD];
  [backdrop.contentView addArrangedSubview:placeholder];
  [HUDWindow addSubview:backdrop];
  [newHUD.widthAnchor constraintEqualToConstant:100].active = true;

  //Fade in animation
  [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{backdrop.alpha = 1;} completion:nil];

  //Yea I know it's stupid to debug stuff this way but I have to make do
  //until I can get OSLog working on iOS 11 again...
  /*
}catch(NSException* e){
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Crap!"
message:e.description
delegate:nil
cancelButtonTitle:@"Okie Dokie"
otherButtonTitles:nil];
[alert show];
[alert release];
}
*/
}

%end

%hook SBVolumeHUDView
-(void)setProgress:(float)volume{
  [newHUD setValue:volume animated:true]; //Adjust the length of the slider based on the current volume
  //Change the image in the HUD depending on how high the volume is
  if (volume == 0)
  [newHUD setMaximumValueImage:[UIImage imageNamed:@"VolumeZero" inBundle:[NSBundle bundleWithPath:@"/System/Library/Frameworks/AVKit.framework"] compatibleWithTraitCollection:NULL]];
  else if(volume <=0.32)
  [newHUD setMaximumValueImage:[UIImage imageNamed:@"VolumeLow" inBundle:[NSBundle bundleWithPath:@"/System/Library/Frameworks/AVKit.framework"] compatibleWithTraitCollection:NULL]];
  else if (volume <= 0.65)
  [newHUD setMaximumValueImage:[UIImage imageNamed:@"VolumeMedium" inBundle:[NSBundle bundleWithPath:@"/System/Library/Frameworks/AVKit.framework"] compatibleWithTraitCollection:NULL]];
  else
  [newHUD setMaximumValueImage:[UIImage imageNamed:@"VolumeHigh" inBundle:[NSBundle bundleWithPath:@"/System/Library/Frameworks/AVKit.framework"] compatibleWithTraitCollection:NULL]];

  %orig;
}
%end

%hook AVVolumeSlider
-(CGRect)maximumValueImageRectForBounds:(CGRect)bounds{
  CGRect newbounds = %orig;
  newbounds.origin.x += newbounds.size.width + 10;  //Set location of the image to the right of the slider based on the width + 10 pixels
  return newbounds;
}
%end
