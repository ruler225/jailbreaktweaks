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
@property (nonatomic, assign) AVStackView *contentView;
@end

@interface AVVolumeButtonControl : UIControl
@property (nonatomic) CGRect frame;
-(void)_setContentImage:(id)image;
@end

@interface SBHUDWindow
-(void)addSubview:(UIView*)arg1;
-(void)_addSubview:(UIView*)arg1 positioned:(NSInteger)arg2 relativeTo:(id)arg3;
@end

@interface SBHUDView
@end


AVVolumeSlider *newHUD = nil;
AVBackdropView *backdrop = nil;
AVVolumeButtonControl *button = nil;
UIView *placeholder = nil;
UIImageView *image;
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
    //bounds.origin.x = 238;
    //bounds.origin.y = 20;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    if(newHUD == nil) {
    newHUD = [[AVVolumeSlider alloc] initWithFrame:bounds];
    //newHUD.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.7];
    //[newHUD _setCornerRadius:13];
   [newHUD setMaximumValueImage:[UIImage imageNamed:@"VolumeHigh" inBundle:[NSBundle bundleWithPath:@"/System/Library/Frameworks/AVKit.framework"] compatibleWithTraitCollection:NULL]];
    bounds.size.width = 162;
    bounds.origin.x = 238;
    bounds.origin.y = 20;
    backdrop = [[AVBackdropView alloc] initWithFrame:bounds];
    bounds.size.width = 35;
    //bounds.origin.x = 114;
    bounds.origin.y = 0;
  //  button = [[AVVolumeButtonControl alloc] initWithFrame:bounds];
    //image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VolumeHigh" inBundle:[NSBundle bundleWithPath:@"/System/Library/Frameworks/AVKit.framework"] compatibleWithTraitCollection:NULL]];
  //  int imagewidth = image.frame.size.width;
  //  int imageheight = image.frame.size.height;
  //  [image.widthAnchor constraintEqualToConstant:48].active = true;
//  [image.heightAnchor constraintEqualToConstant:36].active = true;

placeholder = [[UIView alloc] initWithFrame:bounds];
[placeholder.widthAnchor constraintEqualToConstant:35].active = true;

    }


    bounds.origin.x = 10;
    bounds.origin.y = 0;
    bounds.size.width = 100;
    bounds.size.height = 47;

    //    [backdrop.contentView addArrangedSubview:button];
        [HUDWindow addSubview:backdrop];
        [newHUD.widthAnchor constraintEqualToConstant:100].active = true;
        [backdrop.contentView addArrangedSubview:newHUD];
        [backdrop.contentView addArrangedSubview:placeholder];


        [newHUD setBounds:bounds];



    //     [newHUD setFrame:bounds];



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

%hook AVVolumeSlider
-(CGRect)maximumValueImageRectForBounds:(CGRect)bounds{
  CGRect newbounds = %orig;
  newbounds.origin.x += 30;
  return newbounds;
}

/*
-(CGRect)frame{
  CGRect newframe = %orig;
  newframe.size.width = 100;
  newframe.origin.x = 10;
  return newframe;
}
/*
-(CGRect)bounds{
  CGRect newframe = %orig;
  newframe.size.width = 100;
  newframe.origin.x = 15;
  return newframe;
}
*/
%end
