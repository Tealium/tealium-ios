//
//  TEALWKConfiguration.h
//  WatchKit Catalog
//
//  Created by Jason Koo on 12/3/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEALLogger.h"

/**
 *  This is a lighter-weight version of the TEALConfiguration object meant
    specifically for use in a watchOS extension. Create an instance of this class
    to pass as an argument into a TEALWKExtension init method.
 */
@interface TEALWKExtensionConfiguration : NSObject

/**
 *  The number of track events to store when the host iOS device in not reachable.
 *
 *  Default - 100
 */
@property (nonatomic) NSUInteger offlineDispatchQueueSize;

/**
 *  Tealium log level to use with the extension only.  Default none.
 */
@property TEALLogLevel logLevel;


/**
 *  Creates a default configration instance for a given account / profile / environment combination.  The TiQ information is used to fetch the profile's mobile publish settings used
 *
 *  @return Valid configuration instance to pass to the enableWithConfiguration: method.
 */
+ (instancetype) configuration;



@end
