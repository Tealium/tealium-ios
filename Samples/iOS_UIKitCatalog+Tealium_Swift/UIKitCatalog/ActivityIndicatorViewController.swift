/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use UIActivityIndicatorView.
*/

import UIKit

class ActivityIndicatorViewController: UITableViewController {

    // MARK: Properties
    enum ActivityViewData {
        static let tealiumEvent = "animated_view"
        static let screenName = "activity indicator view"
    }
    enum ActivityEventData {
        static let tealiumEvent = "animation"
        static let eventCategory = "animated views"
        static let eventAction = "start animating"
        static let grayActivityIndicator = "gray activity indicator"
        static let tintedActivityIndicator = "tinted activity indicator"
    }
    weak var delegate: TealiumHelper?
    @IBOutlet weak var grayStyleActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tintedActivityIndicatorView: UIActivityIndicatorView!

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TealiumHelper.trackView(ActivityViewData.tealiumEvent,
                                dataSources: ["screen_name": ActivityViewData.screenName as AnyObject])
        configureGrayActivityIndicatorView()
        configureTintedActivityIndicatorView()
        // When activity is done, use UIActivityIndicatorView.stopAnimating().
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: Configuration
    func configureGrayActivityIndicatorView() {
        grayStyleActivityIndicatorView.activityIndicatorViewStyle = .gray
        grayStyleActivityIndicatorView.startAnimating()
        grayStyleActivityIndicatorView.hidesWhenStopped = true
        TealiumHelper.trackEvent(ActivityViewData.tealiumEvent,
                                 dataSources: ["event_label": ActivityEventData.grayActivityIndicator as AnyObject,
                                               "event_category": ActivityEventData.eventCategory as AnyObject,
                                               "event_action": ActivityEventData.eventAction as AnyObject,
                                               "associated_view": ActivityViewData.screenName as AnyObject])
    }

    func configureTintedActivityIndicatorView() {
        tintedActivityIndicatorView.activityIndicatorViewStyle = .gray
        tintedActivityIndicatorView.color = UIColor.applicationPurpleColor
        tintedActivityIndicatorView.startAnimating()
        TealiumHelper.trackEvent(ActivityViewData.tealiumEvent,
                                 dataSources: ["event_label": ActivityEventData.tintedActivityIndicator as AnyObject,
                                               "event_category": ActivityEventData.eventCategory as AnyObject,
                                               "event_action": ActivityEventData.eventAction as AnyObject,
                                               "associated_view": ActivityViewData.screenName as AnyObject])
    }
}
