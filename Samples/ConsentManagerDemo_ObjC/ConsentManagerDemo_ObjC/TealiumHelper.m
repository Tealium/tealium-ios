//
//  TealiumHelper.m
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 7/18/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import "TealiumHelper.h"

NSString *const TEALIUM_INSTANCE_ID = @"TEALIUM_INSTANCE_1";

@interface TealiumHelper ()

@end

@implementation TealiumHelper

+ (instancetype _Nonnull)sharedInstance {
    static TealiumHelper *tealiumHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tealiumHelper = [[self alloc] init];
    });
    
    return tealiumHelper;
}

- (instancetype)init {
    if (self = [super init]) {
        TEALConfiguration *configuration = [TEALConfiguration configurationWithAccount:@"tealiummobile" profile:@"demo" environment:@"dev"];
        [configuration setLogLevel: TEALLogLevelDev];
        
        // enable Tealium Consent Manager
        [configuration setEnableConsentManager:YES];
        
        _tealium = [Tealium newInstanceForKey:TEALIUM_INSTANCE_ID configuration:configuration];
        _tealium.delegate = self;
        
        // set optional Tealium Consent Manager Delegate
        _tealium.consentManagerDelegate = self;
    }
    
    return self;
}

+ (void)startTracking {
    [TealiumHelper sharedInstance];
}

+ (void)trackEventWithTitle:(NSString * _Nonnull)title dataSources:(NSDictionary * _Nullable)data {
    [[[TealiumHelper sharedInstance] tealium] trackEventWithTitle:title dataSources:data];
}

#pragma mark - TEALConsentManagerDelegate
- (void)consentManagerWillDropDispatch:(TEALDispatch *)dispatch {
//    NSLog(@"🕵️‍♀️%s, %@", __FUNCTION__, [dispatch description]);
}

- (void)consentManagerWillQueueDispatch:(TEALDispatch *)dispatch {
//    NSLog(@"🕵️‍♀️%s, %@", __FUNCTION__, [dispatch description]);
}

- (void)consentManagerDidChangeWithState:(TEALConsentStatus)consentStatus {
//    NSLog(@"🕵️‍♀️%s, %@", __FUNCTION__, [TEALConsentManager consentStatusString:consentStatus]);
}

- (void)consentManagerDidUpdateConsentCategories:(NSArray *)categories {
//    NSLog(@"🕵️‍♀️%s, %@", __FUNCTION__, [categories description]);
}

@end
