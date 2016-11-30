//
//  Tracker.h
//  TealiumiOS
//
//  Created by Jason Koo on 11/12/15.
//  Copyright © 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@import TealiumIOSLifecycle;

/*
 *  Using an abstract class like this is the recommended best practice for 
 *  utilizing analytics or other third party libraries requiring an event 
 *  trigger with optional data.
 */
@interface TealiumHelper : NSObject <TealiumDelegate>

+ (void) startTracking;

+ (void) trackType:(TEALDispatchType)eventType title: (NSString * _Nonnull) title dataSources:(NSDictionary * _Nullable)data;

+ (void) trackEventWithTitle:(NSString *)title dataSources:(NSDictionary *)data;

+ (void) trackViewWithTitle:(NSString *)title dataSources:(NSDictionary *)data;

+ (void) stopTracking;

+ (void) enableRemoteCommandBlock;

+ (void)trackEventWithType:(TEALDispatchType)eventType eventTitle:(NSString *)title dataSources: (NSDictionary *)data completion:(TEALDispatchBlock)completiom;

@end
