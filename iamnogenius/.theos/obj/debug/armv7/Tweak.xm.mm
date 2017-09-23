#line 1 "Tweak.xm"

#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SPTGeniusNowPlayingViewControllerFactoryImpl; @class SPTGeniusNowPlayingViewController; 
static void (*_logos_orig$_ungrouped$SPTGeniusNowPlayingViewController$setGeniusEnabled$)(_LOGOS_SELF_TYPE_NORMAL SPTGeniusNowPlayingViewController* _LOGOS_SELF_CONST, SEL, bool); static void _logos_method$_ungrouped$SPTGeniusNowPlayingViewController$setGeniusEnabled$(_LOGOS_SELF_TYPE_NORMAL SPTGeniusNowPlayingViewController* _LOGOS_SELF_CONST, SEL, bool); static void (*_logos_orig$_ungrouped$SPTGeniusNowPlayingViewControllerFactoryImpl$setGeniusEnabled$)(_LOGOS_SELF_TYPE_NORMAL SPTGeniusNowPlayingViewControllerFactoryImpl* _LOGOS_SELF_CONST, SEL, bool); static void _logos_method$_ungrouped$SPTGeniusNowPlayingViewControllerFactoryImpl$setGeniusEnabled$(_LOGOS_SELF_TYPE_NORMAL SPTGeniusNowPlayingViewControllerFactoryImpl* _LOGOS_SELF_CONST, SEL, bool); 

#line 1 "Tweak.xm"

static void _logos_method$_ungrouped$SPTGeniusNowPlayingViewController$setGeniusEnabled$(_LOGOS_SELF_TYPE_NORMAL SPTGeniusNowPlayingViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, bool enabled){
	_logos_orig$_ungrouped$SPTGeniusNowPlayingViewController$setGeniusEnabled$(self, _cmd, false);
}




static void _logos_method$_ungrouped$SPTGeniusNowPlayingViewControllerFactoryImpl$setGeniusEnabled$(_LOGOS_SELF_TYPE_NORMAL SPTGeniusNowPlayingViewControllerFactoryImpl* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, bool enabled){
	_logos_orig$_ungrouped$SPTGeniusNowPlayingViewControllerFactoryImpl$setGeniusEnabled$(self, _cmd, false);
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SPTGeniusNowPlayingViewController = objc_getClass("SPTGeniusNowPlayingViewController"); MSHookMessageEx(_logos_class$_ungrouped$SPTGeniusNowPlayingViewController, @selector(setGeniusEnabled:), (IMP)&_logos_method$_ungrouped$SPTGeniusNowPlayingViewController$setGeniusEnabled$, (IMP*)&_logos_orig$_ungrouped$SPTGeniusNowPlayingViewController$setGeniusEnabled$);Class _logos_class$_ungrouped$SPTGeniusNowPlayingViewControllerFactoryImpl = objc_getClass("SPTGeniusNowPlayingViewControllerFactoryImpl"); MSHookMessageEx(_logos_class$_ungrouped$SPTGeniusNowPlayingViewControllerFactoryImpl, @selector(setGeniusEnabled:), (IMP)&_logos_method$_ungrouped$SPTGeniusNowPlayingViewControllerFactoryImpl$setGeniusEnabled$, (IMP*)&_logos_orig$_ungrouped$SPTGeniusNowPlayingViewControllerFactoryImpl$setGeniusEnabled$);} }
#line 15 "Tweak.xm"
