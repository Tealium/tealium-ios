//
//  TealiumHelper.swift
//  Blank+Tealium-Swift
//
//  Created by Jason Koo on 11/16/15.
//  Copyright © 2015 Tealium. All rights reserved.
//

/*
*  Using an abstract class like this is the recommended best practice for
*  utilizing analytics or other third party libraries requiring an event
*  trigger with optional data.
*/
import Foundation

import TealiumIOS

let tealiumInstanceID = "1"

class TealiumHelper : NSObject {
    
    static let _sharedInstance = TealiumHelper()
    
    class func sharedInstance() -> TealiumHelper{
        
        return _sharedInstance
    }
    
    class func startTracking() {
        
        let config = TEALConfiguration.init(account: "tealiummobile", profile: "demo", environment: "dev")
        
        guard let tealium = Tealium.newInstanceForKey(tealiumInstanceID, configuration: config) else {
            
            // Any additional failure response here
            
            return
        }
        
        tealium.setDelegate(sharedInstance())
        
        TealiumHelper.incrementLifetimeValue(tealium,key: "Launches", value: 1)
        
    }
    
    class func trackEvent(title: String, dataSources: [String:String]){
        
        Tealium.instanceForKey(tealiumInstanceID)?.trackEventWithTitle(title, dataSources: dataSources)
        
    }
    
    class func trackView(title: String, dataSources: [String:String]){
        
        Tealium.instanceForKey(tealiumInstanceID)?.trackViewWithTitle(title, dataSources: dataSources)
    }
    
    class func stopTracking(){
        
        Tealium.destroyInstanceForKey(tealiumInstanceID)
        
    }
}

extension TealiumHelper : TealiumDelegate {
    
    func tealium(tealium: Tealium!, shouldDropDispatch dispatch: TEALDispatch!) -> Bool {
        
        // Add optional tracking suppression logic here - returning true will destroy
        // any processed dispatch so some conditional must eventually return false
        
        return false
    }
    
    func tealium(tealium: Tealium!, shouldQueueDispatch dispatch: TEALDispatch!) -> Bool {
        
        // Add optional queuing / saving logic here - returning true will save
        // a dispatch so some condition must eventually return false.
        
        return false
    }
    
    func tealium(tealium: Tealium!, didQueueDispatch dispatch: TEALDispatch!) {
        
        // Add optional code here to respond to queuing of dispatches.

    }
    
    func tealium(tealium: Tealium!, didSendDispatch dispatch: TEALDispatch!) {
        
        // Add optional code here to respond to sent dispatches.

    }
    
    func tealium(tealium: Tealium!, webViewIsReady webView: AnyObject!) {

        // Use this to interact with the Tag Management Dispatcher's webview - available only if Tag Management enabled via remote settings.

        
    }
}

// MARK: Example Methods using other Tealium APIs
extension TealiumHelper{
    
    class func incrementLifetimeValue(tealium: Tealium, key: String, value: Int) {
        
        var oldNumber = 0
        
        let persistentData = tealium.persistentDataSourcesCopy()
            
        if let savedNumber = persistentData[key]?.integerValue {

            oldNumber = savedNumber
            
        }
        
        let newNumber = oldNumber + value
        
        let newNumberString = NSString(format: "%i", newNumber)
        
        tealium.addPersistentDataSources([key:newNumberString])
        
        print("Current lifetime value for \(key) is \(newNumber)")
        
        
    }
    
    class func enableRemoteCommand() {
        
        Tealium.instanceForKey(tealiumInstanceID)?.addRemoteCommandId("testCommand", description: "An example remote command block", targetQueue: dispatch_get_main_queue(), block: { (response: TEALRemoteCommandResponse?) -> Void in
            
            // Put any code here that can execute on the main thread - ie content
            // modification, A/B testing, etc.
            
        })
    }
    
}
