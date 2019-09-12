//
//  TealiumWatchHelper.swift
//  WatchOS_Sample_Swift WatchKit Extension
//
//  Created by Jonathan Wong on 3/19/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import Foundation
import TealiumWATCHOSExtension

class TealiumWatchHelper {
    
    static let WatchInstanceIdentifier = "WATCH_INSTANCE_1";
    
    static let shared = TealiumWatchHelper()
    
    let tealiumWatchExtension: TEALWKExtension?
    
    private init() {
        let configuration = TEALWKExtensionConfiguration()
        configuration.logLevel = TEALLogLevel.dev
        self.tealiumWatchExtension = TEALWKExtension.newInstance(forKey: TealiumWatchHelper.WatchInstanceIdentifier, configuration: configuration)
        _ = self.tealiumWatchExtension
    }
    
    class func startTracking() {
        _ = TealiumWatchHelper.shared
    }
    
    class func trackViewWithTitle(title: String, dataSources: [AnyHashable: Any]?) {
        TEALWKExtension.instance(forKey: TealiumWatchHelper.WatchInstanceIdentifier)?.trackView(withTitle: title, dataSources: dataSources)
    }
    
    class func trackEventWithTitle(title: String, dataSources: [AnyHashable: Any]?) {
        _ = TEALWKExtension.instance(forKey: WatchInstanceIdentifier)
        TEALWKExtension.instance(forKey: WatchInstanceIdentifier)?.trackEvent(withTitle: title, dataSources: dataSources)
    }
}
