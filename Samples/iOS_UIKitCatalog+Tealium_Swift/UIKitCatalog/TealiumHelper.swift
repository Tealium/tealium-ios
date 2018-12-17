//
//  TealiumHelper.swift
//  Blank+Tealium-Swift
//
//  Created by Jason Koo on 11/16/15.
//  Updated by Christina Sund on 12/08/18
//  Copyright © 2015 Tealium. All rights reserved.
//

/*
*  Using an abstract class like this is the recommended best practice for
*  utilizing analytics or other third party libraries requiring an event
*  trigger with optional data.
*/
import Foundation
import TealiumIOS

class TealiumHelper: NSObject {

    static let shared = TealiumHelper()
    static let tealiumInstanceIdentifier = "1"
    static var traceIdentifier: String?

    class func startTracking() {
        let config = TEALConfiguration.init(account: "tealiummobile", profile: "demo", environment: "dev")
        let tealium = Tealium.newInstance(forKey: tealiumInstanceIdentifier, configuration: config)
        tealium.setDelegate(self.shared)
        TealiumHelper.incrementLifetimeValue(tealium, key: "launches", value: 1)
        guard let volatileDataSources = Tealium.instance(forKey: tealiumInstanceIdentifier)?
            .volatileDataSourcesCopy() else {
            return
        }
        print("Volatile Data: \(volatileDataSources)")
    }

    class func addToVolatileData(key: String, value: Any) {
        Tealium.instance(forKey: tealiumInstanceIdentifier)?.addVolatileDataSources([key: value])
    }

    class func trackEvent(_ title: String, dataSources: [String: AnyObject]) {
        Tealium.instance(forKey: tealiumInstanceIdentifier)?.trackType(.activity,
                                                               title: title,
                                                               dataSources: dataSources,
                                                               completion: nil)
    }

    class func trackView(_ title: String, dataSources: [String: AnyObject]) {
        Tealium.instance(forKey: tealiumInstanceIdentifier)?.trackView(withTitle: title, dataSources: dataSources)
    }

    class func startTrace(_ traceIdentifier: String) {
        if traceIdentifier == self.traceIdentifier {
            return
        }
        self.traceIdentifier = traceIdentifier
        addToVolatileData(key: "tealium_trace_id", value: traceIdentifier)
    }

    class func stopTrace() {
        if nil == traceIdentifier {
            return
        }
        traceIdentifier = nil
        Tealium.instance(forKey: tealiumInstanceIdentifier)?.trackView(withTitle: "killTrace",
                                                               dataSources: ["event": "kill_visitor_session",
                                                                             "cp.trace_id": "XXXXX"])
    }

    class func stopTracking() {
        Tealium.destroyInstance(forKey: tealiumInstanceIdentifier)
    }

}

extension TealiumHelper: TealiumDelegate {

    func tealium(_ tealium: Tealium, shouldDrop dispatch: TEALDispatch) -> Bool {
        // Add optional tracking suppression logic here - returning true will destroy
        // any processed dispatch so some conditional must eventually return false
        return false
    }

    func tealium(_ tealium: Tealium, shouldQueue dispatch: TEALDispatch) -> Bool {
        // Add optional queuing / saving logic here - returning true will save
        // a dispatch so some condition must eventually return false.
        return false
    }

    func tealium(_ tealium: Tealium, didQueue dispatch: TEALDispatch) {
        // Add optional code here to respond to queuing of dispatches.
    }

    func tealium(_ tealium: Tealium, didSend dispatch: TEALDispatch) {
        // Add optional code here to respond to sent dispatches.
    }

    func tealium(_ tealium: Tealium, webViewIsReady webView: Any) {
        // Use this to interact with the Tag Management Dispatcher's webview.
        // This is available only if Tag Management enabled via remote settings.
    }
}

// MARK: Example Methods using other Tealium APIs
extension TealiumHelper {

    class func incrementLifetimeValue(_ tealium: Tealium, key: String, value: Int) {
        var oldValueInStorage:Int? = 0
        let persistentData = tealium.persistentDataSourcesCopy()
        if let persistentDataValue = (persistentData[key]) as? String {
            oldValueInStorage = Int(persistentDataValue)
        }
        let incrementedValue = oldValueInStorage! + value
        let inrementedValueString = NSString(format: "%i", incrementedValue)
        tealium.addPersistentDataSources([key: inrementedValueString])
        print("Current lifetime value for \(key) is \(incrementedValue)")
    }

    class func enableRemoteCommand() {
        Tealium.instance(forKey: tealiumInstanceIdentifier)?
            .addRemoteCommandID("testCommand",
                                description: "An example remote command block",
                                targetQueue: DispatchQueue.main,
                                responseBlock: {(response: TEALRemoteCommandResponse?) -> Void in
                                    print("Remote command response processed - \(String(describing: response))")
                                    // Put any code here that can execute on the main thread - ie content
                                    // modification, A/B testing, etc.
                                })
    }

}
