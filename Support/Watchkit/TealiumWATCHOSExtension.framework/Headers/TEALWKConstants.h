//
//  TEALWatchKitConstants.h
//  WatchKit Catalog
//
//  Created by Jason Koo on 12/3/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const TEALWKCommandResponseKey;
extern NSString * const TEALWKCommandTrackKey;
extern NSString * const TEALWKCommandTrackArgumentTypeKey;
extern NSString * const TEALWKCommandTrackArgumentInstanceIDKey;
extern NSString * const TEALWKCommandTrackArgumentTitleKey;
extern NSString * const TEALWKCommandTrackArgumentCustomDataKey;

extern NSString * const TEALWKCommandTrackValueEvent;
extern NSString * const TEALWKCommandTrackValueView;

/**
 *  These constants used between the Tealium library and TEALWKExtension classes
 *  to coordinate data transfer to host Tealium Library.
 */
@interface TEALWKConstants : NSObject

@end
