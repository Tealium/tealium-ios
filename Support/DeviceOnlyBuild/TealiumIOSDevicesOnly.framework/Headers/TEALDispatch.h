//
//  TEALDispatch.h
//  TealiumUtilities
//
//  Created by George Webster on 2/13/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * __nonnull const TEALDispatchKey_Dispatch_Type ;
extern NSString * __nonnull const TEALDispatchKey_Dispatch_Service ;
extern NSString * __nonnull const TEALDispatchKey_DataSources_Payload;
extern NSString * __nonnull const TEALDispatchKey_Time_Stamp;


/**
 *  Types of available dispatches
 */
typedef NS_ENUM(NSUInteger, TEALDispatchType) {
    /**
     *  Dispatch type used to track monitiored behavioral actions.
     */
    TEALDispatchTypeActivity,
    /**
     *   Dispatch type that represents data about the user that was infered.
     */
    TEALDispatchTypeDerived,
    /**
     *  Dispatch for view / screen appearances only.
     */
    TEALDispatchTypeView,
    /**
     * Dispatch type when an event represents the interaction between a user and an external resource
     */
    TEALDispatchTypeInteraction,
    /**
     * Dispatch type that represents events that dictate that a desired goal has been reached
     */
    TEALDispatchTypeConversion
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

@interface TEALDispatch : NSObject <NSCoding>

typedef void (^TEALDispatchBlock)(TEALDispatchStatus status, TEALDispatch * _Nonnull dispatch, NSError * _Nullable error);

/**
 *  Type of dispatch, either 'activity', 'view' , 'interaction', 'derived', or 'conversion'
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

/**
 * Converts a TEALDispatch to a NSDictionary 
 */

- (NSDictionary * _Nonnull) asDictionary;

/**
 * Converts a NSDictionary to a TEALDispatch
 */

+ (TEALDispatch * _Nonnull)fromDictionary:(NSDictionary* _Nullable)dictionary;
@end
