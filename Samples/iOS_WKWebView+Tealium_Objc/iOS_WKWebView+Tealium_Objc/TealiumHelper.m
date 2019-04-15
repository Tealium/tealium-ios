//
//  TealiumHelper.m
//  TealiumWatchKitCocoaPodsObjcApp
//
//  Created by Jonathan Wong on 2/13/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import "TealiumHelper.h"

@implementation TealiumHelper

static TealiumHelper *tealiumHelper = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tealiumHelper = [[self alloc] init];
    });
    
    return tealiumHelper;
}

+ (instancetype)sharedInstanceWithView:(UIView *)view {
    tealiumHelper = [[self alloc] initWithView:view];
    return tealiumHelper;

}

- (instancetype)init {
    if (self = [super init]) {
        TEALConfiguration *configuration = [TEALConfiguration configurationWithAccount:@"tealiummobile" profile:@"demo-wkwebview" environment:@"qa"];
        [configuration setLogLevel:TEALLogLevelDev];
        
        _tealium = [Tealium newInstanceForKey:@"1" configuration:configuration];
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        TEALConfiguration *configuration = [TEALConfiguration configurationWithAccount:@"tealiummobile" profile:@"demo-wkwebview" environment:@"qa"];
        [configuration setLogLevel:TEALLogLevelDev];
        configuration.view = view;
        
        _tealium = [Tealium newInstanceForKey:@"1" configuration:configuration];
    }
    return self;
}

+ (void)trackEvent:(NSString *)event {
    [[Tealium instanceForKey:@"1"] trackEventWithTitle:event dataSources:nil];
}

+ (void)trackView:(NSString *)view {
    [[Tealium instanceForKey:@"1"] trackEventWithTitle:view dataSources:nil];
}

+ (void)startTracking {
    [TealiumHelper sharedInstance];
}

+ (void)startTrackingWithView:(UIView *)view {
    [TealiumHelper sharedInstanceWithView:view];
}

+ (void)stopTracking {
    [Tealium destroyInstanceForKey:@"1"];
}
@end
