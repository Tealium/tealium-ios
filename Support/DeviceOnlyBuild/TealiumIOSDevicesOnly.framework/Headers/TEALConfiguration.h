//
//  TEALConfiguration.h
//  Tealium Mobile Library
//
//  Created by George Webster on 3/2/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Configuration Class for the Tealium Mobile Library
 *  An instance of this is passed to Tealium enableWithConfiguration: to start the Collect Library
 */
@interface TEALConfiguration : NSObject

/**
 *  Tealium iQ account name
 */
@property (nonatomic, copy) NSString * _Nonnull accountName;

/**
 *  Tealium iQ profile name, this should be the TiQ profile where the mobile publish settings have been configured for Tealium collect.
 *
 *  Note: This is usually not the same profile used for Collect which defaults to "main"
 */
@property (nonatomic, copy) NSString * _Nonnull profileName;

/**
 *  Tealium iQ evnvironment name.
 *
 *  @example dev/qa/prod
 */
@property (nonatomic, copy) NSString * _Nonnull environmentName;


/**
 *  If assigned, will replace the default mobile publish setting source location with an alternate address. Example - "https://my.domain.com/app/publish.html"
 */
@property (nonatomic) NSString * _Nullable overridePublishSettingsURL;

/**
 *  If assigned, will replace the default address used to retrieve the tag management UTAG.js file.  Example - "https://my.domain.com/app/mobile.html"
 */
@property (nonatomic) NSString * _Nullable overrideTagManagementURL;


#pragma mark - Core Methods
/** @name Core Methods */


/**
 *  Creates a default configration instance for a given account / profile / environment combination.  The TiQ information is used to fetch the profile's mobile publish settings used
 *
 *  @param accountName     String of TiQ / AudienceStream account name
 *  @param profileName     String of TiQ Profile Name
 *  @param environmentName String
 *
 *  @returns Valid configuration instance to pass to the enableWithConfiguration: method.
 */
+ (instancetype _Nonnull) configurationWithAccount:(NSString * _Nonnull)accountName
                                            profile:(NSString * _Nonnull)profileName
                                        environment:(NSString * _Nonnull)environmentName;

/**
 *  Checks to see if configuration is populated with the minimum required properties.
 *
 *  @param configuration TEALConfiguration to check.
 *
 *  @return Boolean of whether the argument configuration is valid.
 */
+ (BOOL) isValidConfiguration:(TEALConfiguration * _Nonnull)configuration;

/**
 *  A unique identifier generated from the account-profile-environment.
 *
 *  @returns instanceID NSString identifier
 */
- (NSString * _Nonnull)instanceID;

@end
