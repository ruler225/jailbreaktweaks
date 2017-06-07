%hook SPTGeniusNowPlayingViewControllerImpl
-(void)setGeniusEnabled:(bool)enabled{
	%orig(false);
}

%end

