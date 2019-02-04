//
//  TEALVisitorProfileFlagAttribute.h
//  Tealium Mobile Library
//
//  Created by George Webster on 6/8/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TEALVisitorProfileBaseAttribute.h"

@interface TEALVisitorProfileFlagAttribute : TEALVisitorProfileBaseAttribute <NSCoding, NSCopying>

/**
 *  Value of the Flag
 *
 *  @return booleon value of the flag
 */
- (BOOL)value;

@end
