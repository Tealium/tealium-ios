//
//  TEALConfiguration+TagManagement.h
//  UIKitCatalog
//
//  Created by Jason Koo on 1/10/16.
//
//

#import "TEALConfiguration.h"

@interface TEALConfiguration (TagManagement)

/**
 *  Read-only flag for remote commands triggerablilty status.
 *
 *  @default YES
 */
- (BOOL) remoteCommandsEnabled;

/**
 *  The url source point for retrieving the UTAG.js embedded mobile.html produced by the TIQ system
 *
 *  @return NSString String representation of the target address.
 */
- (NSString * _Nullable) tagManagementPublishURL;

/**
 *  Override the default publishURL source point with another address.
 *
 *  @param publishURL The replacement URL to use.
 */
- (void) setOverrideTagManagementPublishURL:(NSString * _Nonnull)publishURL;

/**
 *  Enable or disable the remote command triggerability.
 *
 *  @param enabled BOOL to switch remoteCommandEnabled to.
 */
- (void) setRemoteCommandsEnabled:(BOOL)enabled;

@end
