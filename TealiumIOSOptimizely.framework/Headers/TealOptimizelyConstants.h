//
//  TealOptimizelyConstants.h
//  OptimizelyIOSBridge
//
//  Created by Craig Rouse on 27/02/2017.
//  Copyright © 2017 Craig Rouse. All rights reserved.
//

#ifndef TealOptimizelyConstants_h
#define TealOptimizelyConstants_h


#endif /* TealOptimizelyConstants_h */

#pragma mark - Tealium Optimizely Constant DataSource/Variable Keys

extern NSString * const TEALDataSourceKey_Placeholder_OptlyUserIdKey;
extern NSString * const TEALDataSourceKey_Placeholder_OptlyExperimentKey;
extern NSString * const TEALDataSourceKey_Placeholder_OptlyVariationKey;
extern NSString * const TEALDataSourceKey_Placeholder_OptlyEventKey;
extern NSString * const TEALDataSourceKey_Placeholder_OptlyEventValueKey;
extern NSString * const TEALDataSourceKey_OptlyDataPrefix;

extern NSString * const TEALDataSourceKey_OptlyExperimentStartedKey;
extern NSString * const TEALDataSourceKey_OptlyEventTrackedKey;

#pragma mark - Optimizely NSNotification Keys
extern NSString * const TEALOPTLY_Experiment_Started;
extern NSString * const TEALOPTLY_Event_Tracked;

extern NSString * const TEALOPTLY_Notification_Attributes;
extern NSString * const TEALOPTLY_Notification_Event_Key;
extern NSString * const TEALOPTLY_Notification_Event_Value;
extern NSString * const TEALOPTLY_Notification_UserId;
extern NSString * const TEALOPTLY_Notification_Experiment;
extern NSString * const TEALOPTLY_Notification_Variation;
extern NSString * const TEALOPTLY_Notification_Experiment_Experiment_Key;
extern NSString * const TEALOPTLY_Notification_Variation_Variation_Key;

@interface TealOptimizelyConstants : NSObject

@end
