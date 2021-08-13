//
//  TEALVisitorProfileAttribute.h
//  Tealium Mobile Library
//
//  Created by George Webster on 2/4/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Type of Visitor Profile Attribute
 */
typedef NS_ENUM(NSInteger, TEALVisitorProfileAttributeType) {
    /**
     *  Profile Audience
     */
    TEALVisitorProfileAttributeTypeAudience,
    /**
     *  Profile Badge
     */
    TEALVisitorProfileAttributeTypeBadge,
    /**
     *  Profile Date
     */
    TEALVisitorProfileAttributeTypeDate,
    /**
     *  Profile Flag
     */
    TEALVisitorProfileAttributeTypeFlag,
    /**
     *  Profile Metric
     */
    TEALVisitorProfileAttributeTypeMetric,
    /**
     *  Profile Property or "Trait" in the AudienceStream App
     */
    TEALVisitorProfileAttributeTypeProperty
};

@interface TEALVisitorProfileBaseAttribute : NSObject <NSCoding>

/**
 *  Constructor method.
 *
 *  @param type Type of TEALVisitorProfileAttributeType that this base attribute
 *  should be.
 */
- (instancetype)initWithType:(TEALVisitorProfileAttributeType)type;

/**
 *  Compares relavent properties of two attributes for equality
 *
 *  @param object Any NSObject, only TEALVisitorProfileBaseAttribute subclasses can return a true result.
 *
 *  @return boolean of true if relavent values are equal, regardles of object hashing or non relavant properties.
 */
- (BOOL)isEqualAttribute:(id)object;

/**
 *  ID of the attribute
 *
 *  @return string value of the attribute's ID
 */
- (NSString *)attributeID;

/**
 *  Type of attribute
 *
 *  @return valid TEALVisitorProfileAttributeType type
 */
- (TEALVisitorProfileAttributeType)type;

@end



