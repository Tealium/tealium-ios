//
//  Tealium+WatchKit.h
//  WatchKit Catalog
//
//  Created by Jason Koo on 12/11/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "Tealium.h"

@import WatchConnectivity;

@interface Tealium (WatchKit)

/**
 *  Check message from a watchKit extension sendMessage call to determine if any it
        specifies any content for Tealium processing, and if so, if a Tealium
        instance specified is available to process.
 *  
 *  @param message Origin NSDictionary message.
 *
 *  @return Boolean indicating whether the Tealium instance specified in the message
        exists.
 */
+ (BOOL) instanceAvailableForMessage:(NSDictionary<NSString *, id> *)message;

/*
 *  Using same method names as WCSessionDelegate for simplicity. When used with
 the TEALWKExtension class, these methods can be called (relatively) safely
 without interfering with the app's designated WCSessionDelegate.  These
 methods looks for a Tealium specific key within the message and will ignore all other
 message content.
 */

/**
 *  Called on the delegate of the receiver. Will be called on startup if the
 incoming message caused the receiver to launch.
 *
 *  @param session WCSession responding.
 *  @param message Message from Watch Extension.
 */
- (void)session:(WCSession *)session
didReceiveMessage:(NSDictionary<NSString *, id> *)message;

/**
 *  Called on the delegate of the receiver when the sender sends a message that
 expects a reply. Will be called on startup if the incoming message caused the
 receiver to launch.
 *
 *  @param session WCSession responding.
 *  @param message Message from Watch Extension.
 *  @param replyHandler Block responding.
 */
- (void)session:(WCSession *)session
didReceiveMessage:(NSDictionary<NSString *, id> *)message
   replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler;

@end
