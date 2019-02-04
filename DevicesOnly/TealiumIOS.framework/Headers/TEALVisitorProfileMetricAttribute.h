//
//  TEALVisitorProfileMetricAttribute.h
//  Tealium Mobile Library
//
//  Created by George Webster on 6/8/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TEALVisitorProfileBaseAttribute.h"

@interface TEALVisitorProfileMetricAttribute : TEALVisitorProfileBaseAttribute <NSCoding, NSCopying>

/**
 *  Value of the given Metric
 *
 *  @return float value of the metric, default is 0.0
 */
- (float)value;

@end
