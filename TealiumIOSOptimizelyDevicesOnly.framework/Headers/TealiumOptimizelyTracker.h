//
//  OptimizelyTealiumTracker.h
//  OptimizelyIOSBridge
//
//  Created by Craig Rouse on 08/02/2017.
//  Copyright © 2017 Craig Rouse. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifdef TEAL_SOURCE

#import "Tealium.h"

#elif defined(TEAL_TARGET_IOS)

#import <TealiumIOS/TealiumIOS.h>

#elif defined(TEAL_TARGET_TVOS)

#import <TealiumTVOS/TealiumTVOS.h>

#endif
#import <Foundation/Foundation.h>


@interface TealiumOptimizelyTracker : NSObject
@property (nonatomic, readonly) NSMutableSet * tealiumInstances;
@property (nonatomic) NSString * TEOptimizelyExperimentKeyName;
@property (nonatomic) NSString * TEOptimizelyVariationKeyName;
@property (nonatomic) NSString * TEOptimizelyUserIdKeyName;
@property (nonatomic) NSString * TEOptimizelyEventKeyKeyName;
@property (nonatomic) NSString * TEOptimizelyEventValueKeyName;
@property (nonatomic, readonly) BOOL isModuleInitialized;
+ (instancetype) sharedInstance;
- (void) addInstanceWithName: (NSString*) instanceName;
@end
