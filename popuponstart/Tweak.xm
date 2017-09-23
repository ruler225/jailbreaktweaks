%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
	%orig;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello World!"
	message:@"This is my first tweak and I'm happy!"
	delegate:nil
	cancelButtonTitle:@"Youhou!"
	otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

%end