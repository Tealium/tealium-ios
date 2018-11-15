//
//  TEALVisitorProfileCurrentVisit.h
//  Tealium Mobile Library
//
//  Created by George Webster on 3/9/15.
//  Copyright (c) 2015 f. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Container object for attrubtes related only to a users current visit.  Similar to the TEALVisitorProfile but contains only attributes related to the users current visit.
 */
@interface TEALVisitorProfileCurrentVisit : NSObject <NSCoding, NSCopying>

/**
 *  Time current visit was initiated
 *
 *  @return interval as unix timestamp
 */
-(NSTimeInterval) creationTimestamp;

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
 *  Total number of events received during this current visit.
 *
 *  @return count as an unsigned integer
 */
- (NSUInteger) totalEventCount;


@end
