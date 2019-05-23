//
//  TealiumHelper.swift
//  TealiumObjcSwiftApp
//
//  Created by Jonathan Wong on 2/11/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import Foundation
import TealiumIOS

class TealiumHelper {
    
    static let shared = TealiumHelper()
    
    let config = TEALConfiguration(account: "tealiummobile", profile: "remotecommands", environment: "qa")
    
    let tealium: Tealium!
    
    private init() {
        config.logLevel = TEALLogLevel.dev
        self.tealium = Tealium.newInstance(forKey: "1", configuration: config)
    }
    
    public func start() {
        _ = TealiumHelper.shared
    }
    
    class func trackView(with title: String, dataSources: [String: Any]?) {
        TealiumHelper.shared.tealium.trackView(withTitle: title, dataSources: dataSources)
    }
    
    class func trackEvent(with title: String, dataSources: [String: Any]?) {
        TealiumHelper.shared.tealium.trackEvent(withTitle: title, dataSources: dataSources)
    }
    
    
}
