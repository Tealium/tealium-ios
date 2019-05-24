/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use UISwitch.
*/

import UIKit

class SwitchViewController: UITableViewController {

    // MARK: Properties
    enum SwitchViewData {
        static let tealiumEvent = "screen_view"
        static let screenName = "switch view"
    }
    enum SwitchEventData {
        static let tealiumEvent = "switch_toggle"
        static let eventCategory = "options"
        static let eventAction = "toggle"
        static var eventLabel = ""
    }
    @IBOutlet weak var defaultSwitch: UISwitch!
    @IBOutlet weak var tintedSwitch: UISwitch!

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TealiumHelper.trackView(SwitchViewData.tealiumEvent,
                                dataSources: ["screen_name": SwitchViewData.screenName as AnyObject])
        configureDefaultSwitch()
        configureTintedSwitch()
    }

    // MARK: Configuration
    func configureDefaultSwitch() {
        defaultSwitch.setOn(true, animated: false)
        defaultSwitch
            .addTarget(self,
                       action: #selector(SwitchViewController.switchValueDidChange(_:)),
                       for: .valueChanged)
    }

    func configureTintedSwitch() {
        tintedSwitch.tintColor = UIColor.applicationBlueColor
        tintedSwitch.onTintColor = UIColor.applicationGreenColor
        tintedSwitch.thumbTintColor = UIColor.applicationPurpleColor
        tintedSwitch
            .addTarget(self,
                       action: #selector(SwitchViewController.switchValueDidChange(_:)),
                       for: .valueChanged)
    }

    // MARK: Actions
    @objc func switchValueDidChange(_ aSwitch: UISwitch) {
        NSLog("A switch changed its value: \(aSwitch).")
        if aSwitch.isOn {
            SwitchEventData.eventLabel = "on"
        } else {
            SwitchEventData.eventLabel = "off"
        }
        TealiumHelper.trackEvent(SwitchEventData.tealiumEvent,
                                 dataSources: ["event_category": SwitchEventData.eventCategory as AnyObject,
                                               "event_action": SwitchEventData.eventAction  as AnyObject,
                                               "event_label": SwitchEventData.eventLabel  as AnyObject,
                                               "associated_view": SwitchViewData.screenName as AnyObject])
    }
}
