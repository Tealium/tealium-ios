//
//  TEALSessionManager.h
//  TealiumALLTests
//
//  Created by Christina S on 3/18/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEALSettings.h"
#import "TEALSettings+PrivateHeader.h"
#import "TEALDataSources.h"
#import "TEALDataSourceStore.h"

#pragma mark - TEALSessionManagerProtocol

@protocol TEALSessionManagerProtocol <NSObject>

@property (nonatomic, strong) TEALDataSourceStore * _Nonnull dataSourceStore;
@property BOOL initialSession;
@property (nonatomic, assign) NSTimeInterval minutesBetweenSessionID;
@property (nonatomic, assign) NSTimeInterval secondsBetweenTrackEvents;
- (NSString *_Nonnull)sessionID;
- (void)saveSessionID:(NSString * _Nonnull)sessionID;
- (void)saveLastSessionCreated:(NSDate * _Nullable)lastSessionCreation;
- (void)saveLastTrackEvent:(NSDate * _Nullable)lastTrackEvent;
- (NSDate * _Nullable)retrieveLastTrackEvent;
- (NSDate * _Nullable)retrieveLastSessionCreation;
- (void)updateSessionWithInfo:(NSDate * _Nonnull)date generatedSessionId:(NSString * _Nonnull)generatedSessionId;
- (BOOL)qualifiedByMultipleTracks:(NSDate *)savedLastTrackEvent;

@end

@class TEALDataSourceStore;

@interface TEALSessionManager : NSObject <TEALSessionManagerProtocol>

@property (nonatomic, strong) TEALDataSourceStore * _Nonnull dataSourceStore;
@property BOOL initialSession;
@property (nonatomic, strong) id<TEALSettingsProtocol> _Nonnull settings;
@property (nonatomic, assign) NSTimeInterval minutesBetweenSessionID;
@property (nonatomic, assign) NSTimeInterval secondsBetweenTrackEvents;

- (instancetype _Nonnull )initWithDataSourceStore:(TEALDataSourceStore *_Nonnull)dataSourceStore settings:(id<TEALSettingsProtocol>_Nonnull)settings NS_DESIGNATED_INITIALIZER;

+ (NSString *)generateSessionID:(NSDate *_Nonnull)date;

- (NSString *_Nonnull)sessionID;

- (NSString * _Nullable)dateToString:(NSTimeInterval)date;

- (NSDate * _Nullable)stringToDate:(NSString * _Nonnull)string;

- (void)saveLastTrackEvent:(NSDate * _Nullable)lastTrackEvent;

- (NSDate * _Nullable)retrieveLastTrackEvent;

- (void)saveLastSessionCreated:(NSDate * _Nullable)lastSessionCreation;

- (NSDate * _Nullable)retrieveLastSessionCreation;

- (void)saveSessionID:(NSString * _Nonnull)sessionID;

- (void)updateSessionWithInfo:(NSDate * _Nonnull)date generatedSessionId:(NSString * _Nonnull)generatedSessionId;

- (BOOL)qualifiedByMultipleTracks:(NSDate *)savedLastTrackEvent;

@end

