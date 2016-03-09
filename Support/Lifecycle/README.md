# Tealium LifeCycle Tracking Module

The TealiumIOSLifecycle.framework (module) provides lifecycle tracking capability to an
existing 5.0.x implementation of the TealiumIOS framework.

The module adds the additional following data sources for mapping:

* lifecycle_dayofweek_local
* lifecycle_dayssincelaunch
* lifecycle_dayssinceupdate
* lifecycle_dayssincelastwake
* lifecycle_diddetectcrash
* lifecycle_firstlaunchdate
* lifecycle_firstlaunchdate_MMDDYYYY
* lifecycle_hourofday_local
* lifecycle_isfirstlaunch
* lifecycle_isfirstlaunchupdate
* lifecycle_isfirstwakemonth
* lifecycle_isfirstwaketoday
* lifecycle_lastlaunchdate
* lifecycle_lastsleepdate
* lifecycle_lastwakedate
* lifecycle_launchcount
* lifecycle_secondsawake
* lifecycle_priorsecondsawake
* lifecycle_sleepcount
* lifecycle_totallaunchcount
* lifecycle_totalsecondsawake
* lifecycle_totalsleepcount
* lifecycle_totalwakecount
* lifecycle_type
* lifecycle_updatelaunchdate
* lifecycle_wakecount

and the following methods:

* launch
* sleep
* wake 
* setLifecycleAutotrackingIsEnabled:
* incrementLifetimeValuesForKeys:amount:
* currentLifecycleDataSource:


## Installation

* Add the TealiumIOSLifecycle.framework to your project
* Add the framework to your Project's: Target: General: Embedded Binaries section
* In any abstraction class (like TealiumHelper.h) replace any @import TealiumIOS with @importTealiumIOSLifecycle

## Events

The module tracks 3 lifecycle events: 

* launch
* sleep
* wake
* none (for data added to events but not associated with a lifecycle event)

These events are the possible values of the ```lifecycle_type``` data source.

## Automatic Tracking

The module can be configured to automatically listen for the standard UIApplication
notifications to automatically trigger launch, wake and sleep events.

To enable:

```objective-c

// Any time after the newInstanceForKey: init call

[Tealium instanceForKey:@"(uniqueInstanceId)" setLifecycleAutotrackingIsEnabled:YES];


```

### Launch Event

Generated on when a UIApplicationDidFinishLaunchingNotification notification detected.

### Sleep Event

Generated on when a UIApplicationWillEnterForegroundNotification notification detected.

### Wake Event

Generated on when a UIApplicationWillResignActiveNotification notification detected.

## Manual Tracking

**ADVANCED: Not recommended**

Available for specific lifecycle paradigms and non-conventional lifecycle tracking.
These commands will be ignored if the setLifecycleAutotrackingIsEnabled: is set to
YES / true


### Launch Event

To manually track a ```launch``` event, call:

```objective-c

[[Tealium instanceForKey:@"(uniqueInstanceId)"] launch];

```

### Sleep Event

To manually track a ```sleep``` event, call:

```objective-c

[[Tealium instanceForKey:@"(uniqueInstanceId)"] sleep];

```

### Wake Event

To manually track a ```wake``` event, call:

```objective-c

[[Tealium instanceForKey:@"(uniqueInstanceId)"] wake];

```