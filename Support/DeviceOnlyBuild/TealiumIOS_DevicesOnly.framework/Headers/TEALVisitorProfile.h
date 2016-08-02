//
//  TEALVisitorProfile.h
//  Tealium Mobile Library
//
//  Created by George Webster on 1/5/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TEALVisitorProfileCurrentVisit.h"

/**
 *  This class represents a visitor profile retrieved from AudienceStream by the Collect library.
 *
 *  This is meant as a convenience to interact with a profile in a native, typed, safe manner.
 *  To access the "raw" profile as was deserialized from the returned JSON use the rawProfile method.
 */
@interface TEALVisitorProfile : NSObject <NSCoding, NSCopying, NSSecureCoding>

/**
 *  Create instance with vistorID
 *
 *  @param visitorID Current visitorID of user
 *  @return Instance of TEALVisitorProfile
 */
- (instancetype) initWithVisitorID:(NSString *)visitorID;

/**
 *  Valid flag for Profile instance
 *
 *  @return YES if visitorID is valid, otherwise NO
 */
- (BOOL) isValid;

/**
 *  Visitor ID addociated with this profile
 *
 *  @return String representation of user's vistorID
 */
- (NSString *) visitorID;

/**
 *  Audiences this visitor's profile is associated with.
 *
 *  @return Array of TEALVisitorProfileAudienceAttribute objects or nil if none exist
 */
- (NSArray *) audiences;

/**
 *  Badges this visitor's profile is associated with.
 *
 *  @return Array of TEALVisitorProfileBadgeAttribute objects or nil if none exist
 */
- (NSArray *) badges;

/**
 *  Dates this visitor's profile is associated with.
 *
 *  @return Array of TEALVisitorProfileDateAttribute objects or nil if none exist
 */
- (NSArray *) dates;

/**
 *  Flags this visitor's profile is associated with.
 *
 *  @return Array of TEALVisitorProfileFlagAttribute objects or nil if none exist
 */
- (NSArray *) flags;

/**
 *  Metrics this visitor's profile is associated with.
 *
 *  @return Array of TEALVisitorProfileMetricAttribute objects or nil if none exist
 */
- (NSArray *) metrics;

/**
 *  Properties or "Traits" this visitor's profile is associated with.
 *
 *  @return Array of TEALVisitorProfilePropertyAttribute objects or nil if none exist
 */
- (NSArray *) properties;

/**
 *  Current visit instance, similar to the TEALVisitorProfile but contains only attributes related to the users current visit.
 *
 *  @return Object representing the visitor profile's current visit with type TEALVisitorProfileCurrentVisit or nil if current visit has not yet been established.
 */
- (TEALVisitorProfileCurrentVisit *) currentVisit;


/**
 *  Raw profile returned from AudienceStream.  JSON object converted to valid native objects
 *
 *  @return NSDictionary of raw profile objects
 */
- (NSDictionary *) rawProfile;

@end
