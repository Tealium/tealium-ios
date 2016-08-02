//
//  TEALDispatch.h
//  TealiumUtilities
//
//  Created by George Webster on 2/13/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Types of available dispatches
 */
typedef NS_ENUM(NSUInteger, TEALDispatchType) {
    /**
     *  A dispatch with an unassigned type.
     */
    TEALDispatchTypeNone,
    /**
     *  Any non-view type dispatch.
     */
    TEALDispatchTypeEvent,
    /**
     *  Dispatch for view / screen appearances only.
     */
    TEALDispatchTypeView
};

/**
 *  Dispatch Status Types
 */
typedef NS_ENUM(NSUInteger, TEALDispatchStatus) {
    /**
     *  Status not known.
     */
    TEALDispatchStatusUnknown = 0,
    /**
     *  Delivered dispatch.
     */
    TEALDispatchStatusSent,
    /**
     *  Was saved.
     */
    TEALDispatchStatusQueued,
    /**
     *  Destruction requested.
     */
    TEALDispatchStatusDestroyed,
    /**
     *  Other failure.
     */
    TEALDispatchStatusFailed
};


/**
 *  Constants for the two most common dispatch types
 *
 */
extern NSString * _Nonnull const TEALDispatchTypeLinkStringValue; // string actual - "link"
extern NSString * _Nonnull const TEALDispatchTypeViewStringValue; // string actual - "view"

@interface TEALDispatch : NSObject <NSCoding>

typedef void (^TEALDispatchBlock)(TEALDispatchStatus status, TEALDispatch * _Nonnull dispatch, NSError * _Nullable error);

/**
 *  Type of dispatch, either 'link' or 'view'
 */
@property (nonatomic) TEALDispatchType dispatchType;

/**
 *  Optional block assigned to dispatch that can be triggered upon dispatch or queuing of dispatch
 *
 */
@property (nonatomic, strong) TEALDispatchBlock _Nullable assignedBlock;

/**
 *  Name of the dispatch service used to deliver track call.
 *
 */
@property (nonatomic, strong) NSString * _Nullable dispatchServiceName;

/**
 *  The populated datasources available for mapping with the dispatch.
 */
@property (nonatomic, strong) NSDictionary * _Nonnull payload;

/**
 *  Time in Unix epoch of when the dispatch origin track call was called. 
 */
@property (nonatomic) NSTimeInterval timestamp;

/**
 *  Status as human-readable text.
 *
 *  @param dispatchStatus TEALDispatchStatus of a dispatch.
 *
 *  @return NSString representation of the given dispatch status type.
 */
+ (NSString * _Nonnull) stringFromDispatchStatus:(TEALDispatchStatus)dispatchStatus;


@end
