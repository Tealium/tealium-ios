//
//  Tracker.m
//  TealiumiOS
//
//  Created by Jason Koo on 11/12/15.
//  Copyright © 2015 Tealium Inc. All rights reserved.
//

#import "TealiumHelper.h"

NSString *const TEALIUM_INSTANCE_ID = @"1";

@implementation TealiumHelper

static TealiumHelper * _sharedInstance;

+ (instancetype) sharedInstance {
    
    if (!_sharedInstance){
        _sharedInstance = [[TealiumHelper alloc] init];
    }
    
    return _sharedInstance;
}

+ (void) startTracking {
    
    TEALConfiguration *configuration = [TEALConfiguration configurationWithAccount:@"tealiummobile"
                                                                           profile:@"demo"
                                                                       environment:@"dev"];
    
    configuration.collectPollingFrequency = TEALVisitorProfilePollingFrequencyOnRequest;
        
    Tealium *tealiumInstance1 = [Tealium newInstanceForKey:TEALIUM_INSTANCE_ID configuration:configuration];
    
    [tealiumInstance1 setDelegate:[TealiumHelper sharedInstance]];
    
    [TealiumHelper incrementLifetimeValueForKey:@"launches" amount:1];

    
}

+ (void) trackEventWithTitle:(NSString *)title dataSources:(NSDictionary *)data {
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] trackEventWithTitle:title dataSources:data];
}

+ (void) trackViewWithTitle:(NSString *)title dataSources:(NSDictionary *)data {
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] trackViewWithTitle:title dataSources:data];
}

+ (void) stopTracking{
    
    [Tealium destroyInstanceForKey:TEALIUM_INSTANCE_ID];
    
}

#pragma mark - OPTIONAL TEALIUM DELEGATE

- (BOOL) tealium:(Tealium *)tealium shouldDropDispatch:(TEALDispatch *)dispatch {
    
    // Add optional tracking suppression logic here - returning YES will destroy
    // any processed dispatch so some conditional must eventually return NO
    
    return NO;
    
}

- (BOOL) tealium:(Tealium *)tealium shouldQueueDispatch:(TEALDispatch *)dispatch {
    
    // Add optional queuing / saving logic here - returning YES will save
    // a dispatch so some condition must eventually return NO.
    
    return NO;
    
}

- (void) tealium:(Tealium *)tealium didQueueDispatch:(TEALDispatch *)dispatch{
    
    // Add optional code here to respond to queuing of dispatches.
    
}

- (void) tealium:(Tealium *)tealium didSendDispatch:(TEALDispatch *)dispatch{
    
    // Add optional code here to respond to sent dispatches.
    
}

- (void) tealium:(Tealium *)tealium webViewIsReady:(id)webView{
    
    // Use this to interact with the Tag Management Dispatcher's webview - available only if Tag Management enabled via remote settings.
}

#pragma mark - EXAMPLE METHODS USING OTHER TEALIUM APIS

+ (void) incrementLifetimeValueForKey:(NSString *)key amount:(int)number{
    
    NSDictionary *persistentData = [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] persistentDataSourcesCopy];
    
    int oldNumber = [persistentData[key] intValue];
    
    int newNumber = oldNumber + number;
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] addPersistentDataSources:@{key:@(newNumber)}];
    
    NSLog(@"%s Current lifetime value for %@ is: %i", __FUNCTION__, key, newNumber);
    
}

+ (void) enableRemoteCommandBlock {
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] addRemoteCommandId:@"testCommand"
         description:@"An example remote command block"
         targetQueue:dispatch_get_main_queue()
               block:^(TEALRemoteCommandResponse * _Nullable response) {
                   
                   // Put any code here that can execute on the main thread - ie content
                   // modification, A/B testing, etc.
                   
               }];
    
}


@end
