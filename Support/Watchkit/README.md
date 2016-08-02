# Tealium Mobile Library for iOS Version 5.0.4

This mobile library leverages the power of Tealium's [TIQ™ Tag Management](http://tealium.com/products/tealium-iq-tag-management-system/), [AudienceStream™](http://tealium.com/products/audiencestream/) and [Data Access™](http://tealium.com/products/tealium-dataaccess/) products, or any combination of, making them natively available to iOS applications.

## What does Tealium do?

Tealium provides the platform for crafting a modern, scalable and flexible marketing technology stack so you can easily connect and integrate all of your best-in-class solutions.

### Tealium for watchOS

The TealiumWATCHOS.framework is intended to be used in a watchOS extension application where the TealiumIOS.framework has been implemented in the host application.

## How To Get Started

* Check out the [Getting Started](https://community.tealiumiq.com/t5/6-Mobile-Documentation/Mobile-120-Getting-Started-with-iOS-5-x/ta-p/10374) guide for a step by step walkthough of adding Tealium to an extisting project.  
* The public API can viewed online [here](http://tealium.github.io/tealium-ios/), it is also provided in the Documentation directory of this repo as html and docset for Xcode and Dash integration.
* There are many other useful articles on our [community site](https://community.tealiumiq.com).

## Contact Us

* If you have **code questions** or have experienced **errors** please post an issue in the [issues page](../../issues)
* If you have **general questions** or want to network with other users please visit the [Tealium Learning Community](https://community.tealiumiq.com)
* If you have **account specific questions** please contact your Tealium account manager

## Change Log

- 5.0.4 Universal Data Sources & Bug Fixes
    - First track event now waits for webview ready when Tag Management option enabled
    - Lifecycle module first launch auto detection fixed    
    - Devices only builds added to repo (no simulator support frameworks)
    - DSYMs provided with each framework
    - Tealium universal data sources added for all dispatches:
        - event_name (previously link_id)
        - tealium_account
        - tealium_environment
        - tealium_library_name
        - tealium_library_version
        - tealium_profile
        - tealium_random (different 16 digit long number for each track event)
        - tealium_session_id
        - tealium_timestamp_epoch (previously timestamp_unix)
        - tealium_visitor_id (previously tealium_vid)

- 5.0.1 Initial Version


## License

Use of this software is subject to the terms and conditions of the license agreement contained in the file titled "LICENSE.txt".  Please read the license before downloading or using any of the files contained in this repository. By downloading or using any of these files, you are agreeing to be bound by and comply with the license agreement.


---
Copyright (C) 2012-2016, Tealium Inc.
