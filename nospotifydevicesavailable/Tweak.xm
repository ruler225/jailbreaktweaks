%hook SPTNowPlayingBarContentUnitProvider

-(id)initWithPlayer:(id)arg1 gaiaManager:(id)arg2 model:(id)arg3 gaia:(id)arg4
logger:(id)arg5 upsellManager:(id)arg6 nowPlayingManager:(id)arg7
videoSurfaceManager:(id)arg8 theme:(id)arg9 devicesAvailableViewProvider:(id)arg10
barContentProviderRegistry:(id)arg11 shouldHideConnectDevices:(bool)arg12 {
  return %orig(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, true);
}


%end
