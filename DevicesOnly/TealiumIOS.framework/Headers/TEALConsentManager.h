//
//  TEALConsentManager.h
//  FrameworkBuilder
//
//  Created by Jonathan Wong on 4/18/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEALConsentConstants.h"
#import "TEALConsentManagerDelegate.h"
#import "TEALConsentStoreDelegate.h"

@class TEALURLSessionManager;
@protocol TEALDataSourcesProtocol;

@interface TEALConsentManager : NSObject <TEALConsentStoreDelegate>

@property (nonatomic, weak) TEALURLSessionManager *_Nullable sessionManager;
@property (nonatomic, readonly) TEALConsentStatus userConsentStatus;
@property (nonatomic, readonly) BOOL isEnabled;
@property (nonatomic, readonly) BOOL consentConfigurationWasLoaded; // TiQ property for WebView

- (instancetype _Nullable)initWithURLSessionManager:(TEALURLSessionManager *_Nonnull)sessionManager delegate:(id <TEALConsentManagerDelegate>_Nullable)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/**
 Enables consent manager.
 */
- (void)enable;

/**
 Disables consent manager.
 */
- (void)disable;

/**
 Refreshes consent manager settings.
 
 @param completion optional completion block.
 */
// Note: for V2
//- (void)refresh:(void (^_Nullable)(BOOL, NSError *_Nullable))completion;

/**
 Checks if the user has consented
 
 @returns BOOL: YES if the user has consented
 */
- (BOOL)isConsented;

/**
 Checks if the consent manager is disabled
 
 @returns BOOL: YES if the consent manager is disabled
 */
- (BOOL)isDisabled;

/**
 Sets the consentStatus for a user.
 
 @param consentStatus the consentStatus for the user.
 */
- (void)setUserConsentStatus:(TEALConsentStatus)consentStatus;

/**
 Sets the consented categories for a user.
 
 @param categories the categories the user has consented to.
 */
- (void)setUserConsentCategories:(NSArray *_Nonnull)categories;

/**
 Sets the consentStatus and categories for a user.

 @param consentStatus the consentStatus for the user.
 @param categories the categories the user has consented to.
 */
- (void)setUserConsentStatus:(TEALConsentStatus)consentStatus withUserConsentCategories:(NSArray *_Nullable)categories;


/**
 Resets the `consentStatus` to `Unknown` and removes consented categories for a user.
 */
- (void)resetUserConsentPreferences;

/**
 Removes all consented categories for a user.
 */
- (void)resetUserConsentCategories;

/**
 Returns the consented categories for a user.
 
 @returns NSArray: the consented categories for a user.
 */
- (NSArray *_Nullable)userConsentCategories;

/**
 Class method to return consent status as a human readable NSString.
 
 @params consentStatus the consent status to be returned as a NSString.
 
 @returns NSString: the consent status as a NSString.
 */
+ (NSString *_Nonnull)consentStatusString:(TEALConsentStatus)consentStatus;

/**
 Returns NSArray of acceptable category names that can be set.
 
 @returns NSArray: array of acceptable category names.
 */
- (NSArray *_Nonnull)allCategories;

/**
 Filters category names with acceptable category names.
 
 @returns NSArray: acceptable category names only. Empty array if no valid categories.
 */
- (NSArray *_Nonnull)filteredCategories:(NSArray *_Nonnull)categories;

/**
 Enables consent logging which sends an additional log on consent state changes.
 These changes include when consentStatus changes and when the consentedCategories are updated.
 */
- (void)setConsentLoggingEnabled:(BOOL)enable;

/**
 If consent logging is enabled, the SDK sends an event any time consent or categories have changed.
 This feature is optional.
 */
- (BOOL)isConsentLoggingEnabled;

@end
