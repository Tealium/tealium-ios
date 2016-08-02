//
//  TEALLog.h
//  Tealium Mobile Library
//
//  Created by George Webster on 3/5/15.
//  Copyright (c) 2015 Tealium. All rights reserved.
//
//  BRIEF: Logs should be requested only by the main tealium object unless otherwise necessary

#import <Foundation/Foundation.h>

/**
 *  Unsigned integer value that controls the verbosity level of any log output.
 */
typedef NS_ENUM(NSUInteger, TEALLogLevel){
    /**
     *  Nothing is logged to the console, this is the default.
     */
    TEALLogLevelNone = 1,
    /**
     *  Only errors reported.
     */
    TEALLogLevelProd,
    /**
     *  Provides warnings and errors only.
     */
    TEALLogLevelQA,
    /**
     *  Most verbose - Useful for debugging and verification during development.
     */
    TEALLogLevelDev


};

@interface TEALLogger : NSObject

+ (TEALLogLevel) logLevelFromString:(NSString* _Nonnull)string;

+ (NSString * _Nonnull) stringFromLogLevel:(TEALLogLevel) logLevel;

- (instancetype _Nonnull) initWithInstanceID:(NSString * _Nonnull)instanceID;

- (void) enable;

- (void) disable;

- (BOOL) isEnabled;

- (BOOL) updateLogLevel:(NSString * _Nullable)logLevelString;

- (void) logProd:(NSString * _Nonnull) format, ...;

- (void) logQA:(NSString * _Nonnull) format, ...;

- (void) logDev:(NSString * _Nonnull) format, ...;

- (TEALLogLevel) currentLogLevel;

@end
