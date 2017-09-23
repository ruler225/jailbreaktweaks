%hook SPTPlayerTrack
-(NSDictionary *)metadata{
  NSMutableDictionary *newMetadata = [[NSMutableDictionary alloc] init];
  [newMetadata addEntriesFromDictionary: %orig];
  [newMetadata setObject:[NSNumber numberWithBool:FALSE] forKey:@"is_queued"];
  return [NSDictionary dictionaryWithDictionary:newMetadata];
}
%end
