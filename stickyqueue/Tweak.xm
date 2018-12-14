%hook SPTPlayerTrack

-(NSDictionary *)metadata{
    NSDictionary* oldmetadata = %orig;
    //try{
    if (oldmetadata[@"is_queued"]) {
    NSMutableDictionary *newMetadata = [[NSMutableDictionary alloc] init];
    [newMetadata addEntriesFromDictionary:oldmetadata];
    [newMetadata setObject:@0 forKey:@"is_queued"];
    return newMetadata;
  } else
      return oldmetadata;


    /*
  } catch(NSException* e){
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oof!"
     message:e.description
     delegate:nil
     cancelButtonTitle: @"Ummm... ok?"
     otherButtonTitles:nil];
     [alert show];
     [alert release];
     return %orig;
  }
  */
//  NSLog(@"%@", %orig);
//  return %orig;
}
%end
