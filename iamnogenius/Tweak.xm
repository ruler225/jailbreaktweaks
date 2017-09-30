%hook SPTGeniusNowPlayingViewController
-(void)setGeniusEnabled:(bool)enabled{
	%orig(false);
}

%end

%hook SPTGeniusNowPlayingViewControllerImpl
-(void)setGeniusEnabled:(bool)enabled{
	%orig(false);
}

%end

