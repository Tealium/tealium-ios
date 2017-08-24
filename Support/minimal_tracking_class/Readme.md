# Tealium Objective-C Minimal Tracking Class (iOS)

### Table of Contents ###

- [Purpose](#purpose)
- [Features](#features)
- [Public API](#public-api)
- [Usage](#usage)
- [Known Issues/Warnings](#known-issues-warnings)
- [Release Notes](#release-notes)

## Purpose

This tracking class provides a very simple API to send tracking data to Tealium's UDH or TiQ Tag Management products. It is intended for use with iOS widgets, or apps that have very limited resources to work with and/or simple tracking needs. For most use cases, it is recommended to use one of the following full-featured Tealium libraries:

https://github.com/Tealium/tealium-ios
https://github.com/Tealium/tealium-swift

**If you have an iOS app and a widget, it is recommended to run the minimal tracking class in the widget, and one of the standard iOS libraries in the main host app.**

## Features

### Included Features

* Generates a persistent Visitor ID for use with UDH
* If enabled, passes data directly to Tealium's UDH
* If enabled, allows client-side (device-side) Tag Management using Tealium iQ through a non-rendered WKWebView object
* TiQ only: If the web view fails to load (e.g. due to a bad connection), events will be queued until the webview loads. The queue is not persistent, so an app restart would clear the queue. Note: currently, the length of the queue is unlimited, so large payloads may lead to high memory usage if the user is offline. 

### Absent Features/Limitations

* No offline caching of events; the class has no way to establish if there is a current active network connection. If this feature is important, you should check for a connection before sending the event to the trackView or trackEvent methods, and implement your own tracking queue

## Public API

### Method: ```instanceWithAccount:```
| Parameter      | Data Type    | Description/Usage                                                                                                    | Example                                |
|----------------|--------------|----------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| account        | NSString     | Your Tealium account                                                                                                 | @"tealiummobile"                       |
| profile        | NSString     | Your Tealium profile                                                                                                 | @"demo"                                |
| environment    | NSString     | Environment you wish to target (used for iQ only)                                                                    | @"dev", @"qa", @"prod"                 |
| domainOverride | NSString     | Overrides the base domain for Tealium iQ. Used if you are self-hosting.                                              | @"https://tags.yourdomain.com/"        |
| enableFeatures | NSArray      | Specifies list of features to enable (use provided constants). If nil or empty, all features are disabled by default | @[TealiumFeatureUDH, TealiumFeatureIQ] |
| additionalData | NSDictionary | Dictionary of data to be sent automatically on every dispatch                                                        | @{@"user_id":@"someemail@test.com"}    |


### Method: ```trackView:```
| Parameter  | Data Type    | Description/Usage                                                      | Example                             |   |
|------------|--------------|------------------------------------------------------------------------|-------------------------------------|---|
| title      | NSString     | Screen Title of the view to track                                      | @"Homescreen"                       |   |
| payload    | NSDictionary | Dictionary of key/value pairs to be sent with the screen view          | @{@"user_id":@"someemail@test.com"} |   |
| completion | block        | Code block to be executed upon completion of the track call (nullable) | nil                                 |   |

### Method: ```trackEvent:```
| Parameter  | Data Type    | Description/Usage                                                      | Example                             |   |
|------------|--------------|------------------------------------------------------------------------|-------------------------------------|---|
| title      | NSString     | Name of the event to track                                      | @"Home Button Tapped"                       |   |
| payload    | NSDictionary | Dictionary of key/value pairs to be sent with the event          | @{@"user_id":@"someemail@test.com"} |   |
| completion | block        | Code block to be executed upon completion of the track call (nullable) | nil                                 |   |


## Usage

1. Add a new import statement: ```#import "TealiumTracker.h"```
2. Initialize the class using the ```instanceWithAccount``` method
3. Send trackView calls whenever a new screen comes into view
4. Send trackEvent calls whenever the user performs an action, e.g. clicking a call-to-action button

## Known Issues/Warnings

* Very limited logging enabled.
* No offline caching

## Release Notes

#### 0.1
- Initial Release
- Tag Management support added
- Collect/UDH support added