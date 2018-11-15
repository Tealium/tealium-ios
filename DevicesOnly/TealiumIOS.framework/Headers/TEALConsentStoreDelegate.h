//
//  TEALConsentStoreDelegate.h
//  TealiumALLTests
//
//  Created by Jonathan Wong on 5/10/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEALConsentConstants.h"

@class TEALConsentConfiguration;

@protocol TEALConsentStoreDelegate <NSObject>

/**
 Delegate method that provides the consent status that the consent store did update to.
 
 @param consentStatus the consent status after being set.
 */
- (void)consentStoreConsentDidChangeWithState:(TEALConsentStatus)consentStatus;

@optional

/**
 Optional delegate method that provides the updated category names.
 
 @param categoryNames the category names after being set.
 */
- (void)consentStoreDidUpdateConsentedCategoryNames:(NSArray * _Nullable)categoryNames;

@end
