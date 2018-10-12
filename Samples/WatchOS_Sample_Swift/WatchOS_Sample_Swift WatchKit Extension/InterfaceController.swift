//
//  InterfaceController.swift
//  WatchOS_Sample_Swift WatchKit Extension
//
//  Created by Jonathan Wong on 3/19/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import TealiumWATCHOSExtension

class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // Example of tracking when InterfaceController is activated
        TealiumWatchHelper.trackViewWithTitle(title: NSStringFromClass(self.classForCoder), dataSources: ["foo": "bar"])
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    /**
     Example of tracking an event on button press
     */
    @IBAction func trackEvent() {
        TealiumWatchHelper.trackEventWithTitle(title: "event_title", dataSources: ["button_event": "track_button"])
    }
    
    /**
     Example of sending a message through WCSession and a track view call.
     */
    @IBAction func sendMessage1() {
        if WCSession.isSupported() {
            let session = WCSession.default
            if session.isReachable {
                let message = [TEALWKCommandTrackKey: [ // REQUIRED: command to parse
                    TEALWKCommandTrackArgumentTitleKey: "message_1", // REQUIRED: title of view/event to track
                    TEALWKCommandTrackArgumentTypeKey: TEALWKCommandTrackValueView, // REQUIRED: the type view/event to track
                    TEALWKCommandTrackValueView: "InterfaceController.view",    // OPTIONAL: value of view
                    TEALWKCommandTrackArgumentInstanceIDKey: TealiumWatchHelper.WatchInstanceIdentifier,   // OPTIONAL: Tealium instance identifier
                    "foo": "bar",   // OPTIONAL: any data you want to pass
                    "order_id": "1" // OPTIONAL: any data you want to pass
                    ]]
                session.sendMessage(message, replyHandler: { (replyMessage: [String: Any]) in
                    // optionally use the replyHandler
                    print(String(describing: replyMessage))
                }, errorHandler: { (Error) in
                    // if any errors, optionally handle it
                    print(Error.localizedDescription)
                })
            }
        }
    }
    
    /**
     Example of sending a message through WCSession and a track event call.
     */
    @IBAction func sendMessage2() {
        if WCSession.isSupported() {
            let session = WCSession.default
            if session.isReachable {
                let message = [TEALWKCommandTrackKey: [ // REQUIRED: command to parse
                    TEALWKCommandTrackArgumentTitleKey: "message_2", // REQUIRED: title of view/event to track
                    TEALWKCommandTrackArgumentTypeKey: TEALWKCommandTrackValueEvent, // REQUIRED: the type view/event to track
                    TEALWKCommandTrackValueEvent: "message_sent",    // OPTIONAL: value of event
                    "message": "hello from Tealium"   // OPTIONAL: any data you want to pass
                    ]]
                session.sendMessage(message, replyHandler: { (replyMessage: [String: Any]) in
                    // optionally use the replyHandler
                    print(String(describing: replyMessage))
                }, errorHandler: { (Error) in
                    // if any errors, optionally handle it
                    print(Error.localizedDescription)
                })
            }
        }
    }
    
    /**
     Example of sending a message through WCSession and not using any Tealium-specific functionality.
     i.e. This message is not processed by Tealium SDK.
     */
    @IBAction func sendMessage3() {
        if WCSession.isSupported() {
            let session = WCSession.default
            if session.isReachable {
                let message = [
                    "title": "order",
                    "order_id": "123"
                ]
                session.sendMessage(message, replyHandler: { (replyMessage: [String: Any]) in
                    // optionally use the replyHandler
                    print(String(describing: replyMessage))
                }, errorHandler: { (error) in
                    // if any errors, optionally handle it
                    print(error.localizedDescription)
                })
            }
        }
    }
}


