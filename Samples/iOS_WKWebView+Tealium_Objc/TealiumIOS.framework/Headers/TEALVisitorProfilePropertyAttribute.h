//
//  TEALVisitorProfilePropertyAttribute.h
//  Tealium Mobile Library
//
//  Created by George Webster on 6/8/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//
//
//  Personal information about the user.
//  also know as a "Trait" via the AS Web App.

#import <Foundation/Foundation.h>

#import "TEALVisitorProfileBaseAttribute.h"

@interface TEALVisitorProfilePropertyAttribute : TEALVisitorProfileBaseAttribute <NSCoding, NSCopying, NSSecureCoding>

/**
 *  String value of a given property or trait.
 *
 *  @return valid string or nil if none
 */
- (NSString *)value;

@end
