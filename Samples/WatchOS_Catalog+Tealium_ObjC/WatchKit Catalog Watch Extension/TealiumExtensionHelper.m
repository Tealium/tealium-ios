//
//  Tracker.m
//  TealiumiOS
//
//  Created by Jason Koo on 11/12/15.
//  Copyright © 2015 Tealium Inc. All rights reserved.
//

#import "TealiumExtensionHelper.h"


NSString *const TEALIUM_INSTANCE_ID = @"1";

@implementation TealiumExtensionHelper

static TealiumExtensionHelper * _sharedInstance;

#pragma mark - PRIVATE

+ (instancetype) sharedInstance {
    
    if (!_sharedInstance){
        _sharedInstance = [[TealiumExtensionHelper alloc] init];
        [TealiumExtensionHelper startTracking];
    }
    
    return _sharedInstance;
}

+ (void) startTracking {
    
    TEALWKExtensionConfiguration *configuration = [TEALWKExtensionConfiguration configuration];
    
    configuration.logLevel = TEALLogLevelDev;
    
    [TEALWKExtension newInstanceForKey:TEALIUM_INSTANCE_ID configuration:configuration];
    
}


#pragma mark - PUBLIC

+ (void) trackEventWithTitle:(NSString *)title dataSources:(NSDictionary *)data {
    
    [[TEALWKExtension instanceForKey:TEALIUM_INSTANCE_ID] trackEventWithTitle:title dataSources:data];
}

+ (void) trackViewWithTitle:(NSString *)title dataSources:(NSDictionary *)data {
    
    [[TEALWKExtension instanceForKey:TEALIUM_INSTANCE_ID] trackViewWithTitle:title dataSources:data];
}

@end
