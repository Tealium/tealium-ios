//
//  TealiumHelper.h
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 7/18/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>
@import TealiumIOS;

@interface TealiumHelper : NSObject<TealiumDelegate, TEALConsentManagerDelegate>

@property (nonatomic, strong) Tealium *tealium;

/**
 Shared singleton instance of TealiumHelper.
 */
+(instancetype _Nonnull)sharedInstance;

/**
 Creates singleton instance of TealiumHelper.
 */
+ (void)startTracking;

/**
 Triggers an event tracking call
 @param title any NSString identifier for the event
 @param data an optional NSDictionary of additional data for Tealium mapping.
 */
+ (void)trackEventWithTitle:(NSString * _Nonnull)title dataSources:(NSDictionary * _Nullable)data;

@end
