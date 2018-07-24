//
//  TEALConsentConstants.h
//  TealiumIOS
//
//  Created by Jonathan Wong on 4/18/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>

// event specs
extern NSString *const TEALJSONSettingsKeyAvailableCategories;
extern NSString *const TEALConsentedCategoryNamesKey;
extern NSString *const TEALForbiddenCategoriesKey;
extern NSString *const TEALTrackingConsentedKey;
extern NSString *const TEALConsentEventName;

// dictionary keys
extern NSString *const TEALConsentStatusKey;

// archiving
extern NSString *const TEALConsentConfigurationArchivableKey;

// approved category names
extern NSString *const TEALConsentCategoryAnalytics;
extern NSString *const TEALConsentCategoryAffiliates;
extern NSString *const TEALConsentCategoryDisplayAds;
extern NSString *const TEALConsentCategoryEmail;
extern NSString *const TEALConsentCategoryPersonalization;
extern NSString *const TEALConsentCategorySearch;
extern NSString *const TEALConsentCategorySocial;
extern NSString *const TEALConsentCategoryBigData;
extern NSString *const TEALConsentCategoryMobile;
extern NSString *const TEALConsentCategoryEngagement;
extern NSString *const TEALConsentCategoryMonitoring;
extern NSString *const TEALConsentCategoryCRM;
extern NSString *const TEALConsentCategoryCDP;
extern NSString *const TEALConsentCategoryCookieMatch;
extern NSString *const TEALConsentCategoryMisc;

/**
 Defines the status of the Privacy Manager.
 Unknown - Privacy Manager might not be initialized or we are waiting on user input.
 Consented - User agrees to tracking.  This covers sending all or individual categories.
 NotConsented - User disagrees to tracking. Do not track calls.
 Disabled - The developer does not use Privacy Manager and the SDK sends track calls like normal.
 */
typedef NS_ENUM(NSInteger, TEALConsentStatus) {
    Unknown,
    Consented,
    NotConsented,
    Disabled
};
