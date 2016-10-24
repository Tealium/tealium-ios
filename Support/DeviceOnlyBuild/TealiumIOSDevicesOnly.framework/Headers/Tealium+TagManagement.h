//
//  Tealium+TagManagement.h
//  Tealium
//
//  Created by Jason Koo on 8/20/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "Tealium.h"
#import "TEALRemoteCommandResponse.h"
#import "TEALConfiguration+TagManagement.h"

@interface Tealium (TagManagement)

/**
 *  Adds a remote command block that can be triggered by the instance's TIQ templates.
 *
 *  @param commandID NSString that identifies this code block
 *  @param description Optional NSString description of the command block
 *  @param queue The dispatch queue to run the command on.  Note, any UI
 *  commands must be done on the main thread.
 *  @param responseBlock An optional block that returns a TEALRemoteCommandResponse 
 *  object whenever the command is executed.
 */
- (void) addRemoteCommandID:(NSString* _Nonnull)commandID
                description:(NSString* _Nullable)description
                targetQueue:(dispatch_queue_t _Nonnull)queue
              responseBlock:(void (^ _Nonnull)(TEALRemoteCommandResponse * _Nonnull response))responseBlock;

/**
 *  Removes a remote command block for the given commandID
 *
 *  @param commandID NSString identifier for the command block to remove.
 */
- (void) removeRemoteCommandID:(NSString * _Nonnull)commandID;

@end
