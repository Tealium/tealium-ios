//
//  TEALPrivacyManagerDelegate.h
//  FrameworkBuilder
//
//  Created by Jonathan Wong on 4/19/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEALConsentConstants.h"

@class TEALDispatch;

@protocol TEALConsentManagerDelegate <NSObject>

/**
 * Delegate method that provides the consent status that the consent manager
 * will be updated to.
 *
 * @param consentStatus the consent status to be set.
 */
- (void)consentManagerWillChangeWithState:(TEALConsentStatus)consentStatus;

/**
 * Delegate method that provides the consent status that the consent manager
 * did update to.
 *
 * @param consentStatus the consent status after being set.
 */
- (void)consentManagerDidChangeWithState:(TEALConsentStatus)consentStatus;

/**
 * Delegate method that provides the updated category names.
 *
 * @param categoryNames the category names after being set.
 */
- (void)consentManagerDidUpdateConsentedCategoryNames:(NSArray * _Nullable)categoryNames;

@optional

/**
 * Delegate method that provides the dispatch before being dropped.
 *
 * @param dispatch the dispatch being dropped.
 */
- (void)consentManagerWillDropDispatch:(TEALDispatch * _Nullable)dispatch;

/**
 * Delegate method that provides the dispatch before being queued.
 *
 * @param dispatch the dispatch being queued.
 */
- (void)consentManagerWillQueueDispatch:(TEALDispatch * _Nullable)dispatch;

@end
