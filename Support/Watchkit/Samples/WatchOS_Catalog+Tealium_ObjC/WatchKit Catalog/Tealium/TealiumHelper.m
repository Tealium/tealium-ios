//
//  Tracker.m
//  TealiumiOS
//
//  Created by Jason Koo on 11/12/15.
//  Copyright © 2015 Tealium Inc. All rights reserved.
//

#import "TealiumHelper.h"

/**
 *  Make certain this matches the key of at least one Tealium library instance 
    on the parent app.
 */
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
    
    Tealium *instance = [Tealium instanceForKey:TEALIUM_INSTANCE_ID];
    
    if (instance){
        
        return;
    }
    
    // Configure Tealium
    TEALConfiguration *configuration = [TEALConfiguration configurationWithAccount:@"tealiummobile"
                                                                           profile:@"demo"
                                                                       environment:@"dev"];
    
    // Create Tealium Instance
    Tealium *tealiumInstance1 = [Tealium newInstanceForKey:TEALIUM_INSTANCE_ID configuration:configuration];
    
    [tealiumInstance1 setDelegate:[TealiumHelper sharedInstance]];
    
}

+ (void) trackEventWithTitle:(NSString *)title dataSources:(NSDictionary *)data {
    
    [self startTracking];
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] trackEventWithTitle:title dataSources:data];
        
}

+ (void) trackViewWithTitle:(NSString *)title dataSources:(NSDictionary *)data {
    
    [self startTracking];
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] trackViewWithTitle:title dataSources:data];
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

    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] addRemoteCommandID:@"testCommand"
        description:@"An example remote command block"
        targetQueue:dispatch_get_main_queue()
        responseBlock:^(TEALRemoteCommandResponse * _Nullable response) {
        
        NSLog(@"%s response: %@", __FUNCTION__, response);
        // Put any code here that can execute on the main thread - ie content
        // modification, A/B testing, etc.
        
    }];
    
}

#pragma mark - WATCHKIT RESPONSE HANDLING


+ (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler {
    
    // Alternatively TEALWKDelegate could be imported and used directly by the class originally calling this method.
    
    // Turn on the library if not already on.
    [self startTracking];
    
    [[Tealium instanceForKey:TEALIUM_INSTANCE_ID] session:session didReceiveMessage:message replyHandler:replyHandler];
    
}



@end
