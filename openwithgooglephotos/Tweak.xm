%hook SpringBoard
-(void)applicationOpenURL: (NSURL*)arg1 {
    if([arg1.scheme isEqual:@"photos-redirect"] || [arg1.scheme isEqual:@"photos"])
		arg1 = [NSURL URLWithString:@"googlephotos://"];
	%orig;
}

%end
