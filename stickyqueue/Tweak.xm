%hook SPTPlayerTrack
-(NSDictionary *)metadata{
    NSMutableDictionary *newMetadata = NSMutableDictionary.new;
    [newMetadata addEntriesFromDictionary:%orig];
    [newMetadata setObject:@0 forKey:@"is_queued"];
    return newMetadata;
}
%end
