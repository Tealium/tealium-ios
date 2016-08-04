//
//  TEALConfiguration+TagManagement.h
//  UIKitCatalog
//
//  Created by Jason Koo on 1/10/16.
//
//

#ifdef TEAL_SOURCE
#import "TEALConfiguration.h"
#else
#import <TealiumIOS/TEALConfiguration.h>
#endif

@interface TEALConfiguration (Lifecycle)

/**
 *  Read-only flag for lifecycle autotracking status.
 *
 *  @default YES
 */
- (BOOL) isAutotrackingLifecycleEnabled;

/**
 *  Enable or disable the lifecycle autotracking system.
 *
 *  @param enable BOOL whether autotracking should be on or off.
 */
- (void) setAutotrackingLifecycleEnabled:(BOOL)enable;

@end
