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
@protocol TEALAuditLoggable;

@interface TEALConsentManager : NSObject <TEALConsentStoreDelegate>

@property (nonatomic, weak) TEALURLSessionManager *_Nullable sessionManager;
@property (nonatomic, readonly) TEALConsentStatus consentStatus;
@property (nonatomic, readonly) BOOL isEnabled;
@property (nonatomic, strong) id <TEALAuditLoggable> _Nullable auditLogger;

- (instancetype _Nullable)initWithURLSessionManager:(TEALURLSessionManager *_Nonnull)sessionManager delegate:(id <TEALConsentManagerDelegate>_Nullable)delegate;

- (instancetype _Nullable)init NS_UNAVAILABLE;

/**
 Enables consent manager.
 */
- (void)enable;

/**
 Disables consent manager.
 */
- (void)disable;

/**
 Enables auditing which sends an additional log on consent state changes.
 These changes include when consentStatus changes and when the consentedCategories are updated.
 */
- (void)enableAuditing:(BOOL)enable;

/**
 Refreshes consent manager settings.
 
 @param completion optional completion block.
 */
- (void)refresh:(void (^_Nullable)(BOOL, NSError *_Nullable))completion;

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
 Updates consentStatus.
 
 @param consentStatus the consentStatus to update to.
 */
- (void)updateConsentStatus:(TEALConsentStatus)consentStatus;

/**
 Updates consented category names.
 
 @param categoryNames the category names to update to.
 */
- (void)updateConsentedCategoryNames:(NSArray *_Nullable)categoryNames;

/**
 Removes all consented category names.
 */
- (void)removeConsentedCategories;

/**
 Returns the consented categories.
 
 @returns NSArray: the consented categories.
 */
- (NSArray *_Nullable)consentedCategoryNames;

/**
 Returns NSArray of TEALConsentCategory representing the user defined categories.
 
 @returns NSArray: array of TEALConsentCategory
 */
- (NSArray *_Nullable)consentCategories;

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
- (NSArray *_Nonnull)acceptableCategoryNames;

/**
 Filters category names with acceptable category names.
 
 @returns NSArray: acceptable category names only.
 */
- (NSArray *_Nonnull)filteredCategoryNames:(NSArray *_Nonnull)categoryNames;

@end
