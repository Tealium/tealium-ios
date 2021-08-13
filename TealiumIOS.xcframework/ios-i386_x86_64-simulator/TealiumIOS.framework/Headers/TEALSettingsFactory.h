//
//  TEALSettingsFactory.h
//  TealiumALLTests
//
//  Created by Jonathan Wong on 4/25/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TEALSettings;
@class TEALConfiguration;
@class TEALURLSessionManager;
@protocol TEALSettingsProtocol;

#pragma mark - TEALSettingsFactoryProtocol

@protocol TEALSettingsFactoryProtocol <NSObject>

- (TEALSettings *_Nullable)settingsFromConfiguration:(TEALConfiguration *_Nonnull)configuration urlSessionManager:(TEALURLSessionManager *_Nullable)urlSessionManager;

@end

#pragma mark - TEALSettingsFactory

@interface TEALSettingsFactory : NSObject <TEALSettingsFactoryProtocol>

- (TEALSettings *_Nullable)settingsFromConfiguration:(TEALConfiguration *_Nonnull)configuration urlSessionManager:(TEALURLSessionManager *_Nullable)urlSessionManager;

@end
