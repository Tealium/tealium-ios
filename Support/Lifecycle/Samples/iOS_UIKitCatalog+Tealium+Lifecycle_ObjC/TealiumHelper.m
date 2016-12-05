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
                                                                           profile:@"main"
                                                                       environment:@"dev"];
    
    [configuration setAutotrackingLifecycleEnabled:YES];
    
    Tealium *tealiumInstance1 = [Tealium newInstanceForKey:TEALIUM_INSTANCE_ID configuration:configuration];
    
    
    [tealiumInstance1 setDelegate:[TealiumHelper sharedInstance]];
    
    [tealiumInstance1 addVolatileDataSources:@{@"volatileTestKey":@"volatileTestValue"}];
    
    if (![tealiumInstance1 respondsToSelector:@selector(launch)]){
        NSLog(@"%s Lifecycle Module not loaded.", __FUNCTION__);
    }
    
}

+ (void) trackEventWithTitle:(NSString *)title dataSources:(NSDictionary *)data {
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] trackEventWithTitle:title dataSources:data];
}

+ (void) trackViewWithTitle:(NSString *)title dataSources:(NSDictionary *)data {
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] trackViewWithTitle:title dataSources:data];
}

+ (void) trackType: (TEALDispatchType) eventType title: (NSString *)title dataSources: (NSDictionary *)dataSources {
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] trackType:eventType title: title dataSources:dataSources completion:nil];
    
}

+ (void) stopTracking{
    
    [Tealium destroyInstanceForKey:TEALIUM_INSTANCE_ID];
    
}

#pragma mark - OPTIONAL TEALIUM DELEGATE

- (BOOL) tealium:(Tealium *)tealium shouldDropDispatch:(TEALDispatch *)dispatch {

    // Add optional tracking suppression logic here - returning YES will destroy
    // any processed dispatch so some conditional must eventually return false
    
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

+ (void) enableRemoteCommandBlock {

    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] addRemoteCommandID:@"logger" description:@"An example remote command block" targetQueue:dispatch_get_main_queue() responseBlock:^(TEALRemoteCommandResponse * _Nullable response) {
        
        NSLog(@"%s response: %@", __FUNCTION__, response);
        // Put any code here that can execute on the main thread - ie content
        // modification, A/B testing, etc.
        
    }];
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] addRemoteCommandID:@"blogger" description:@"An example remote command block" targetQueue:dispatch_get_main_queue() responseBlock:^(TEALRemoteCommandResponse * _Nullable response) {
        
        NSLog(@"%s response: %@", __FUNCTION__, response);
        // Put any code here that can execute on the main thread - ie content
        // modification, A/B testing, etc.
        
    }];
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] addRemoteCommandID:@"flogger" description:@"An example remote command block" targetQueue:dispatch_get_main_queue() responseBlock:^(TEALRemoteCommandResponse * _Nullable response) {
        
        NSLog(@"%s response: %@", __FUNCTION__, response);
        // Put any code here that can execute on the main thread - ie content
        // modification, A/B testing, etc.
        
    }];
    
    
}


@end
