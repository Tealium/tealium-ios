//
//  AppDelegate.swift
//  WatchOS_Sample_Swift
//
//  Created by Jonathan Wong on 3/19/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import UIKit
import WatchConnectivity
import TealiumIOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupWatchConnectivity()
        TealiumHelper.startTracking()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
}

extension AppDelegate: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }
    
    /**
     This method must be implemented in order to receive messages from the accompanying watchOS app
     */
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        // Optionally handle any custom payload
        guard let messagePayload = message[TEALWKCommandTrackKey] else { // REQUIRED
            return
        }
        
        guard let payload = messagePayload as? Dictionary<AnyHashable, Any> else {
            return
        }
        
        guard let title = payload[TEALWKCommandTrackArgumentTitleKey] as? String, let type = payload[TEALWKCommandTrackArgumentTypeKey] as? String else { // REQUIRED
            return
        }
        
        if title == "order" {
            let value = payload[TEALWKCommandTrackValueView]
            let instanceIdentifier = payload[TEALWKCommandTrackArgumentInstanceIDKey]
            print("type: \(type), view: \(String(describing: value)), \(String(describing: instanceIdentifier))")
        } else if title == "message_2" {
            let value = payload["event"]
            print("type: \(type), event: \(String(describing: value))")
        }
        
        // Forwards the request to Tealium SDK
        TealiumHelper.session(session, didReceiveMessage: message, replyHandler: replyHandler)
    }
}
