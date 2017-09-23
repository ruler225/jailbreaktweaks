bool deviceLocked;

%hook SBNCNotificationDispatcher
-(bool)_isDeviceLocked{
	deviceLocked = %orig;
	return deviceLocked;
}
%end


%hook SBHomeHardwareButton

-(bool)_acceleratedSinglePressRecognizerShouldBegin{
	if(deviceLocked){
	return TRUE;
}else{
	return %orig;
}
return %orig;	
}


%end

