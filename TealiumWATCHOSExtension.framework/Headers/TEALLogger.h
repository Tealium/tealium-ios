//
//  TEALLog.h
//  Tealium Mobile Library
//
//  Created by George Webster on 3/5/15.
//  Copyright (c) 2015 Tealium. All rights reserved.
//
//  BRIEF: Logs should be requested only by the main tealium object unless otherwise necessary

#import <Foundation/Foundation.h>

#import "TEALLogLevels.h"

@interface TEALLogger : NSObject

+ (TEALLogLevel) logLevelFromString:(NSString* _Nonnull)string;

+ (NSString * _Nonnull) stringFromLogLevel:(TEALLogLevel) logLevel;

- (instancetype _Nonnull) initWithInstanceID:(NSString * _Nonnull)instanceID;

- (void) enable;

- (void) disable;

- (BOOL) isEnabled;

- (BOOL) updateLogLevel:(TEALLogLevel)logLevel;

- (void) logProd:(NSString * _Nonnull) format, ...;

- (void) logQA:(NSString * _Nonnull) format, ...;

- (void) logDev:(NSString * _Nonnull) format, ...;

- (TEALLogLevel) currentLogLevel;

@end
