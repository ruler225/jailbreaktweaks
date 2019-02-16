%hook SBHUDController

-(void)presentHUDView:(UIView*)HUDView autoDismissWithDelay:(CGFloat)delay{
  CGRect dimensions = [[UIScreen mainScreen] bounds];
  HUDView.frame = dimensions;
  %orig;
}
%end
