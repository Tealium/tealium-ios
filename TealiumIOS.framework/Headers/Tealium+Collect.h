//
//  Tealium+Collect.h
//  Tealium
//
//  Created by Jason Koo on 8/20/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "Tealium.h"
#import "TEALVisitorProfile.h"
#import "TEALConfiguration+Collect.h"

@interface Tealium (Collect)

/**
 *  The visitor profile url associated with the current user.
 *
 *  @returns NSURL An optional NSURL object.
 */
- (NSURL * _Nullable) profileURL;

/**
 *  Where Collect will retrieve profile definitions.
 *
 *  @returns NSURL An optional NSURL object.
 */
- (NSURL * _Nullable) profileDefinitionURL;

/**
 *  Copy of the Unique visitor ID per Account / Device combination.
 *
 *  @return String value of the visitorID for the Account the library was enabled with.
 */
- (NSString * _Nullable) visitorIDCopy;


/**
 *  Last retrieved profile instance.  This is updated every time the profile is 
 *  queried.  Depending on the settings the library was enabled with, this could 
 *  be after every sendEvent:customData: call or only on explicit request.
 *
 *  @return Returns valid TEALVisitorProfile object.  Its properties might be 
 *  nil of nothing is loaded into them yet.
 */
- (TEALVisitorProfile * _Nullable) cachedVisitorProfileCopy;


/**
 *  Retrieves the current visitor profile from AudienceStream.
 *
 *  @param completion Completion block with retrieved TEALVisitorProfile 
 *  instance and an error should any problems occur.
 */
- (void) fetchVisitorProfileWithCompletion:(void (^ _Nullable)(TEALVisitorProfile * _Nullable profile, NSError * _Nullable error))completion;

@end
