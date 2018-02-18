@interface AVVolumeSlider : UISlider
@property (nonatomic) bool collapsed;
@property (nonatomic) bool collapsedOrExcluded;
@property (nonatomic) float effectiveVolumeLimit;
@property (nonatomic) CGSize extrinsicContentSize;
@property (nonatomic) bool hasFulllScreenAppearance;
@property (nonatomic) bool included;
@property (nonatomic, assign) NSNumber *unclampedValue;
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@property (nonatomic) float value;

//-(void)setValue:(float)arg1 animated:(bool)arg2;
-(id)initWithFrame:(CGRect)arg1;
-(void)_setCornerRadius:(CGFloat)arg1;
+(id)alloc;
@end

@interface AVStackView : UIStackView
@end

@interface AVBackdropView : AVStackView
@end

@interface AVVolumeButtonControl : UIControl
@end

@interface SBHUDWindow
-(void)addSubview:(UIView*)arg1;
-(void)_addSubview:(UIView*)arg1 positioned:(NSInteger)arg2 relativeTo:(id)arg3;
@end

@interface SBHUDView
@end


AVVolumeSlider *newHUD = nil;
SBHUDWindow *HUDWindow;

%hook SBHUDWindow

-(id)initWithScreen:(id)arg1 debugName:(id)arg2{
  HUDWindow = %orig;
  return HUDWindow;
}
%end

%hook SBHUDController

-(void)presentHUDView:(UIView*)HUDView autoDismissWithDelay:(CGFloat)arg2{
  //try{
    %orig;
    HUDView.hidden = true;
    CGRect bounds;
    bounds.size.width = 100;
    bounds.size.height = 47;
    bounds.origin.x = 300;
    bounds.origin.y = 20;
    if(newHUD == nil) {
    newHUD = [[AVVolumeSlider alloc] initWithFrame:bounds];
    newHUD.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.7];
    [newHUD _setCornerRadius:13];
    }

        [HUDWindow addSubview:newHUD];

  %orig;
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
  -(id)setProgress:(float)volume{
    [newHUD setValue:volume animated:true];
    return %orig;
  }
%end
