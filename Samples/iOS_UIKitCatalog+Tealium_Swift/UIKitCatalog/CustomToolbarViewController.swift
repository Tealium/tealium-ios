/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to customize a UIToolbar.
*/

import UIKit

class CustomToolbarViewController: UIViewController {

    // MARK: Properties
    enum CustomToolbarViewData {
        static let tealiumEvent = "account_view"
        static let screenName = "custom toolbar view"
    }
    @IBOutlet weak var toolbar: UIToolbar!

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TealiumHelper.trackView(CustomToolbarViewData.tealiumEvent,
                                dataSources: ["screen_name": CustomToolbarViewData.screenName as AnyObject])
        configureToolbar()
    }

    // MARK: Configuration
    func configureToolbar() {
        let toolbarBackgroundImage = UIImage(named: "toolbar_background")
        toolbar.setBackgroundImage(toolbarBackgroundImage, forToolbarPosition: .bottom, barMetrics: .default)
        let toolbarButtonItems = [
            customImageBarButtonItem,
            flexibleSpaceBarButtonItem,
            customBarButtonItem
        ]
        toolbar.setItems(toolbarButtonItems, animated: true)
    }

    // MARK: UIBarButtonItem Creation and Configuration
    var customImageBarButtonItem: UIBarButtonItem {
        let customBarButtonItemImage = UIImage(named: "tools_icon")
        let customImageBarButtonItem = UIBarButtonItem(image: customBarButtonItemImage,
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(CustomToolbarViewController
                                                                        .barButtonItemClicked(_:)))
        customImageBarButtonItem.tintColor = UIColor.applicationPurpleColor
        return customImageBarButtonItem
    }

    var flexibleSpaceBarButtonItem: UIBarButtonItem {
        // Note that there's no target/action since this represents empty space.
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

    var customBarButtonItem: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(title: NSLocalizedString("Button", comment: ""),
                                            style: .plain,
                                            target: self,
                                            action: #selector(CustomToolbarViewController.barButtonItemClicked(_:)))
        let backgroundImage = UIImage(named: "WhiteButton")
        barButtonItem.setBackgroundImage(backgroundImage, for: UIControl.State(), barMetrics: .default)
        let attributes = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.applicationPurpleColor
        ]
        barButtonItem.setTitleTextAttributes(convertToOptionalNSAttributedStringKeyDictionary(attributes), for: UIControl.State())
        return barButtonItem
    }

    // MARK: Actions
    @objc func barButtonItemClicked(_ barButtonItem: UIBarButtonItem) {
        NSLog("A bar button item on the custom toolbar was clicked: \(barButtonItem).")
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
