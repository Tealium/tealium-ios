//
//  TealiumIOS.h
//  TealiumIOS
//
//  Created by Jason Koo on 11/8/15.
//  Copyright © 2015 Tealium Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for TealiumIOS.
FOUNDATION_EXPORT double TealiumIOSVersionNumber;

//! Project version string for TealiumIOS.
FOUNDATION_EXPORT const unsigned char TealiumIOSVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <TealiumIOS/PublicHeader.h>
#import <TealiumIOS_DevicesOnly/Tealium.h>
#import <TealiumIOS_DevicesOnly/Tealium+Collect.h>
#import <TealiumIOS_DevicesOnly/Tealium+TagManagement.h>
#import <TealiumIOS_DevicesOnly/Tealium+WatchKit.h>
#import <TealiumIOS_DevicesOnly/TealiumDelegate.h>

#import <TealiumIOS_DevicesOnly/TEALConfiguration+Collect.h>
#import <TealiumIOS_DevicesOnly/TEALConfiguration+TagManagement.h>
#import <TealiumIOS_DevicesOnly/TEALConfiguration.h>
#import <TealiumIOS_DevicesOnly/TEALDataSourceConstants.h>
#import <TealiumIOS_DevicesOnly/TEALDispatch.h>
#import <TealiumIOS_DevicesOnly/TEALRemoteCommandResponse.h>
#import <TealiumIOS_DevicesOnly/TEALVisitorProfile.h>
#import <TealiumIOS_DevicesOnly/TEALVisitorProfileCurrentVisit.h>
