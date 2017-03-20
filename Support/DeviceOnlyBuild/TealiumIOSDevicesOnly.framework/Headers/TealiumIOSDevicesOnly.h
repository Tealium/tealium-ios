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
#import <TealiumIOSDevicesOnly/Tealium.h>
#import <TealiumIOSDevicesOnly/Tealium+Collect.h>
#import <TealiumIOSDevicesOnly/Tealium+TagManagement.h>
#import <TealiumIOSDevicesOnly/Tealium+WatchKit.h>
#import <TealiumIOSDevicesOnly/TealiumDelegate.h>

#import <TealiumIOSDevicesOnly/TEALConfiguration+Collect.h>
#import <TealiumIOSDevicesOnly/TEALConfiguration+TagManagement.h>
#import <TealiumIOSDevicesOnly/TEALConfiguration.h>
#import <TealiumIOSDevicesOnly/TEALDataSourceConstants.h>
#import <TealiumIOSDevicesOnly/TEALDispatch.h>
#import <TealiumIOSDevicesOnly/TEALLogLevels.h>
#import <TealiumIOSDevicesOnly/TEALRemoteCommandResponse.h>
#import <TealiumIOSDevicesOnly/TEALVisitorProfile.h>
#import <TealiumIOSDevicesOnly/TEALVisitorProfileCurrentVisit.h>
