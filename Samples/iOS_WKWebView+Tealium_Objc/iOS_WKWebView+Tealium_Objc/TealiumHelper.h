//
//  TealiumHelper.h
//  TealiumWatchKitCocoaPodsObjcApp
//
//  Created by Jonathan Wong on 2/13/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>
@import TealiumIOS;

@interface TealiumHelper : NSObject

@property (nonatomic, strong) Tealium *_Nonnull tealium;
@property (nonatomic, assign) BOOL initNeeded;

+ (instancetype _Nonnull)sharedInstance;

+ (void)trackEvent:(NSString *_Nonnull)event;

+ (void)trackView:(NSString *_Nonnull)view;

+ (void)startTracking;

+ (void)startTrackingWithView:(UIView *_Nonnull)view;

+ (void)stopTracking;

@end
