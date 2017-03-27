//
//  Tracker.h
//  TealiumiOS
//
//  Created by Jason Koo on 11/12/15.
//  Copyright © 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@import TealiumIOS;

/*
 *  Using an abstract class like this is the recommended best practice for 
 *  utilizing analytics or other third party libraries requiring an event 
 *  trigger with optional data.
 */
@interface TealiumHelper : NSObject<TealiumDelegate>

+ (void) startTracking;

+ (void) trackType:(TEALDispatchType)eventType title: (NSString * _Nonnull) title dataSources:(NSDictionary * _Nullable)data;

+ (void) trackEventWithTitle:(NSString * _Nonnull)title dataSources:(NSDictionary * _Nullable)data;

+ (void) trackViewWithTitle:(NSString *_Nonnull)title dataSources:(NSDictionary *_Nullable)data;

+ (void) stopTracking;

+ (void) incrementLifetimeValueForKey:(NSString *_Nonnull)key amount:(int)number;

+ (void) enableRemoteCommandBlock;

@end
