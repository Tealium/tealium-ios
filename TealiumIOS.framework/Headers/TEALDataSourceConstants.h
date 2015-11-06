//
//  TEALCollectDatasources.h
//  Tealium Mobile Library
//
//  Created by George Webster on 4/17/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

// TODO: Make a strings file instead?

#import <Foundation/Foundation.h>

#pragma mark - Library Constants

extern NSString * const TEALDefaultPublishVersion;

#pragma mark - UDO / Datasource Keys

extern NSString * const TEALDataSourceKey_ApplicationName;
extern NSString * const TEALDataSourceKey_ApplicationRDNS;
extern NSString * const TEALDataSourceKey_ApplicationVersion;
extern NSString * const TEALDataSourceKey_AssociatedViewTitle;
extern NSString * const TEALDataSourceKey_Autotracked;
extern NSString * const TEALDataSourceKey_CallType;
extern NSString * const TEALDataSourceKey_Carrier;
extern NSString * const TEALDataSourceKey_CarrierISO;
extern NSString * const TEALDataSourceKey_CarrierMCC;
extern NSString * const TEALDataSourceKey_CarrierMNC;
extern NSString * const TEALDataSourceKey_ConnectionType;
extern NSString * const TEALDataSourceKey_Device;
extern NSString * const TEALDataSourceKey_DeviceArchitecture;
extern NSString * const TEALDataSourceKey_DeviceBatteryLevel;
extern NSString * const TEALDataSourceKey_DeviceCPUType;
extern NSString * const TEALDataSourceKey_DeviceIsCharging;
extern NSString * const TEALDataSourceKey_DeviceLanguage;
extern NSString * const TEALDataSourceKey_DeviceResolution;
extern NSString * const TEALDataSourceKey_DeviceOrientation;
extern NSString * const TEALDataSourceKey_DeviceOSVersion;
extern NSString * const TEALDataSourceKey_DeviceToken;
extern NSString * const TEALDataSourceKey_EventName;
extern NSString * const TEALDataSourceKey_EventTitle;
extern NSString * const TEALDataSourceKey_ExceptionName;
extern NSString * const TEALDataSourceKey_ExceptionReason;
extern NSString * const TEALDataSourceKey_ExceptionTrace;
extern NSString * const TEALDataSourceKey_ExceptionTotalCount;
extern NSString * const TEALDataSourceKey_LibraryVersion;

extern NSString * const TEALDataSourceKey_LifecycleDayOfWeek;
extern NSString * const TEALDataSourceKey_LifecycleDaysSinceLaunch;
extern NSString * const TEALDataSourceKey_LifecycleDaysSinceUpdate;
extern NSString * const TEALDataSourceKey_LifecycleFirstLaunchDate;
extern NSString * const TEALDataSourceKey_LifecycleFirstLaunchDate_MMDDYYYY;
extern NSString * const TEALDataSourceKey_LifecycleHourOfDayLocal;
extern NSString * const TEALDataSourceKey_LifecycleIsFirstLaunch;
extern NSString * const TEALDataSourceKey_LifecycleIsFirstLaunchAfterUpdate;
extern NSString * const TEALDataSourceKey_LifecycleIsFirstWakeThisMonth;
extern NSString * const TEALDataSourceKey_LifecycleIsFirstWakeToday;
extern NSString * const TEALDataSourceKey_LifecycleLastLaunchDate;
extern NSString * const TEALDataSourceKey_LifecycleLastWakeDate;
extern NSString * const TEALDataSourceKey_LifecycleLastSleepDate;
extern NSString * const TEALDataSourceKey_LifecycleLaunchCount;
extern NSString * const TEALDataSourceKey_LifecyclePriorSecondsAwake;
extern NSString * const TEALDataSourceKey_LifecycleSecondsAwake;
extern NSString * const TEALDataSourceKey_LifecycleSleepCount;
extern NSString * const TEALDataSourceKey_LifecycleType;
extern NSString * const TEALDataSourceKey_LifecycleTotalLaunchCount;
extern NSString * const TEALDataSourceKey_LifecycleTotalWakeCount;
extern NSString * const TEALDataSourceKey_LifecycleTotalSleepCount;
extern NSString * const TEALDataSourceKey_LifecycleUpdateLaunchDate;
extern NSString * const TEALDataSourceKey_LifecycleWakeCount;

extern NSString * const TEALDataSourceKey_ObjectClass;
extern NSString * const TEALDataSourceKey_Orientation;
extern NSString * const TEALDataSourceKey_Origin;
extern NSString * const TEALDataSourceKey_Pagetype;
extern NSString * const TEALDataSourceKey_Platform;
extern NSString * const TEALDataSourceKey_SelectedRow;
extern NSString * const TEALDataSourceKey_SelectedSection;
extern NSString * const TEALDataSourceKey_SelectedTitle;
extern NSString * const TEALDataSourceKey_SelectedValue;
extern NSString * const TEALDataSourceKey_SystemVersion;
extern NSString * const TEALDataSourceKey_Timestamp;
extern NSString * const TEALDataSourceKey_TimestampLocal;
extern NSString * const TEALDataSourceKey_TimestampOffset;
extern NSString * const TEALDataSourceKey_TimestampUnix;
extern NSString * const TEALDataSourceKey_TealiumID;
extern NSString * const TEALDataSourceKey_TraceID;
extern NSString * const TEALDataSourceKey_UUID;
extern NSString * const TEALDataSourceKey_ViewTitle;
extern NSString * const TEALDataSourceKey_ViewHeight;
extern NSString * const TEALDataSourceKey_ViewWidth;
extern NSString * const TEALDataSourceKey_VisitorID;
extern NSString * const TEALDataSourceKey_WasQueued;
extern NSString * const TEALDataSourceKey_WebViewServiceType;
extern NSString * const TEALDataSourceKey_WebViewURL;


#pragma mark - UDO / Datasource Values

extern NSString * const TEALDataSourceValue_ConnectionCellular;
extern NSString * const TEALDataSourceValue_ConnectionWifi;
extern NSString * const TEALDataSourceValue_ConnectionNone;
extern NSString * const TEALDataSourceValue_EventName;
extern NSString * const TEALDataSourceValue_False;
extern NSString * const TEALDataSourceValue_IOS;
extern NSString * const TEALDataSourceValue_LifecycleLaunch;
extern NSString * const TEALDataSourceValue_LifecycleWake;
extern NSString * const TEALDataSourceValue_LifecycleSleep;
extern NSString * const TEALDataSourceValue_LifecycleTerminate;
extern NSString * const TEALDataSourceValue_Link;
extern NSString * const TEALDataSourceValue_Mobile;
extern NSString * const TEALDataSourceValue_Pagetype;
extern NSString * const TEALDataSourceValue_True;
extern NSString * const TEALDataSourceValue_TV;
extern NSString * const TEALDataSourceValue_TvOS;
extern NSString * const TEALDataSourceValue_View;
extern NSString * const TEALDataSourceValue_Exception;
extern NSString * const TEALDataSourceValue_ExceptionCaught;
extern NSString * const TEALDataSourceValue_ExceptionUncaught;
extern NSString * const TEALDataSourceValue_Unknown;
extern NSString * const TEALDataSourceValue_WatchOS;
extern NSString * const TEALDataSourceValue_Wearable;


#pragma mark - Collect API Keys

extern NSString * const TEALCollectKey_Account;
extern NSString * const TEALCollectKey_Environment;
extern NSString * const TEALCollectKey_Profile;
extern NSString * const TEALCollectKey_TraceID;
extern NSString * const TEALCollectKey_VisitorID;

@interface TEALDataSourceConstants : NSObject

@end
