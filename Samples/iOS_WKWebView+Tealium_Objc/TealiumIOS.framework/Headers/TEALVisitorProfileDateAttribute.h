//
//  TEALVisitorProfileDateAttribute.h
//  Tealium Mobile Library
//
//  Created by George Webster on 6/8/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TEALVisitorProfileBaseAttribute.h"

@interface TEALVisitorProfileDateAttribute : TEALVisitorProfileBaseAttribute <NSCoding, NSCopying>

/**
 *  Date as Unix timestamp
 *
 *  @return time interval timetamp representation of a date
 */
- (NSTimeInterval)timestamp;

@end