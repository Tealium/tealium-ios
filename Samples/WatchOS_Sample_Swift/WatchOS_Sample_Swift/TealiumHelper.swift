//
//  TealiumHelper.swift
//  WatchOS_Sample_Swift
//
//  Created by Jonathan Wong on 3/19/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import Foundation
import TealiumIOSLifecycle

class TealiumHelper: NSObject {
    
    static let TealiumInstanceIdentifier = "TEALIUM_INSTANCE_1"
    
    /**
     Shared singleton instance of TealiumHelper
     */
    static let shared = TealiumHelper()
    
    let tealium: Tealium
    
    private override init() {
        let configuration = TEALConfiguration(account: "tealiummobile", profile: "demo", environment: "dev")
        configuration.logLevel = TEALLogLevel.dev
        tealium = Tealium.newInstance(forKey: TealiumHelper.TealiumInstanceIdentifier, configuration: configuration)
        super.init()
        tealium.setDelegate(self)
    }
    
    /**
     Creates singleton instance of TealiumHelper
    */
    class func startTracking() {
        _ = TealiumHelper.shared
    }
    
    /**
     Triggers an event tracking call
     @param title any String identifier for the event
     @param data an optional Dictionary of additional data for Tealium mapping.
    */
    class func trackEventWithTitle(title: String, dataSources: [AnyHashable: Any]?) {
        TealiumHelper.shared.tealium.trackEvent(withTitle: title, dataSources: dataSources)
    }
    
    /**
     Triggers a view tracking call
     @param title any NSString identifier for the view
     @param data an optional NSDictionary of additional data for Tealium mapping.
    */
    class func trackViewWithTitle(title: String, dataSources: [AnyHashable: Any]?) {
        TealiumHelper.shared.tealium.trackView(withTitle: title, dataSources: dataSources)
    }
    
    /**
     Forwards the request to the Tealium SDK to optionally make a track call
     */
    class func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        // Turn on the Tealium library if not already on
        startTracking()
        
        // REQUIRED: forwards any track view/event calls to Tealium SDK
        Tealium.instance(forKey: TealiumHelper.TealiumInstanceIdentifier)?.session(session, didReceiveMessage: message, replyHandler: replyHandler)
    }
}

extension TealiumHelper: TealiumDelegate {
    
}
