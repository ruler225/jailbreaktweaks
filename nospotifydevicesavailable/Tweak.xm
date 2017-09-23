%hook SPTNowPlayingBarContentUnitProvider

-(id)initWithPlayer:(id)arg1 gaiaManager:(id)arg2 model:(id)arg3 gaia:(id)arg4
logCenter:(id)arg5 upsellManager:(id)arg6 tinkerbellManager:(id)arg7
tinkerbellStoryRegistry:(id)arg8 nowPlayingManager:(id)arg9
videoSurfaceManager:(id)arg10 theme:(id)arg11 chromecastBarViewFactory:(id)arg12
barContentProviderRegistry:(id)arg13 shouldHideConnectDevices:(bool)arg14 {
  return %orig(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, true);
}


%end
