/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use UIButton. The buttons are created using storyboards,
    but each of the system buttons can be created in code by using the UIButton.buttonWithType() initializer.
    See the UIButton interface for a comprehensive list of the various UIButtonType values.
*/

import UIKit

class ButtonViewController: UITableViewController {
    // MARK: Properties
    enum ButtonViewData {
        static let tealiumEvent = "product_view"
        static let screenName = "product detail view"
    }
    enum ButtonEventData {
        static let tealiumEvent = "button_click"
        static let eventCategory = "button"
        static let eventAction = "click"
    }
    enum CartEventData {
        static let tealiumEventCartAdd = "cart_add"
        static let tealiumEventCartRemove = "cart_remove"
    }
    @IBOutlet weak var systemTextButton: UIButton!
    @IBOutlet weak var systemContactAddButton: UIButton!
    @IBOutlet weak var systemDetailDisclosureButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var attributedTextButton: UIButton!

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // All of the buttons are created in the storyboard, but configured below.
        configureSystemTextButton()
        configureSystemContactAddButton()
        configureSystemDetailDisclosureButton()
        configureImageButton()
        configureAttributedTextSystemButton()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var data = DefaultData.productData
        data["screen_name"] = ButtonViewData.screenName as AnyObject
        TealiumHelper.trackView(ButtonViewData.tealiumEvent,
                                dataSources: data)
    }

    // MARK: Configuration
    func configureSystemTextButton() {
        let buttonTitle = NSLocalizedString("Add To Cart", comment: "")
        systemTextButton.setTitle(buttonTitle, for: UIControl.State())
        systemTextButton.addTarget(self, action: #selector(ButtonViewController.addToCart(_:)), for: .touchUpInside)
    }

    func configureSystemContactAddButton() {
        systemContactAddButton.backgroundColor = UIColor.clear
        systemContactAddButton.addTarget(self,
                                         action: #selector(ButtonViewController.buttonClicked(_:)),
                                         for: .touchUpInside)
    }

    func configureSystemDetailDisclosureButton() {
        systemDetailDisclosureButton.backgroundColor = UIColor.clear
        systemDetailDisclosureButton.addTarget(self,
                                               action: #selector(ButtonViewController.buttonClicked(_:)),
                                               for: .touchUpInside)
    }

    func configureImageButton() {
        // To create this button in code you can use UIButton.buttonWithType() with a parameter value of .Custom.
        // Remove the title text.
        imageButton.setTitle("", for: UIControl.State())
        imageButton.tintColor = UIColor.applicationPurpleColor
        let imageButtonNormalImage = UIImage(named: "x_icon")
        imageButton.setImage(imageButtonNormalImage, for: UIControl.State())
        // Add an accessibility label to the image.
        imageButton.accessibilityLabel = NSLocalizedString("X Button", comment: "")
        imageButton.addTarget(self, action: #selector(ButtonViewController.buttonClicked(_:)), for: .touchUpInside)
    }

    func configureAttributedTextSystemButton() {
        let buttonTitle = NSLocalizedString("Remove From Cart", comment: "")
        // Set the button's title for normal state.
        let normalTitleAttributes = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.applicationBlueColor,
            convertFromNSAttributedStringKey(NSAttributedString.Key.strikethroughStyle): NSUnderlineStyle.single.rawValue
        ] as [String: Any]
        let normalAttributedTitle = NSAttributedString(string: buttonTitle, attributes: convertToOptionalNSAttributedStringKeyDictionary(normalTitleAttributes))
        attributedTextButton.setAttributedTitle(normalAttributedTitle, for: UIControl.State())
        // Set the button's title for highlighted state.
        let highlightedTitleAttributes = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.green,
            convertFromNSAttributedStringKey(NSAttributedString.Key.strikethroughStyle): NSUnderlineStyle.thick.rawValue
        ] as [String: Any]
        let highlightedAttributedTitle = NSAttributedString(string: buttonTitle, attributes: convertToOptionalNSAttributedStringKeyDictionary(highlightedTitleAttributes))
        attributedTextButton.setAttributedTitle(highlightedAttributedTitle, for: .highlighted)
        attributedTextButton.addTarget(self,
                                       action: #selector(ButtonViewController.removeFromCart(_:)),
                                       for: .touchUpInside)
    }

    // MARK: Actions

    @objc func buttonClicked(_ sender: UIButton) {
        NSLog("A button was clicked: \(sender).")
        TealiumHelper.trackEvent(ButtonEventData.tealiumEvent,
                                 dataSources: ["event_category": ButtonEventData.eventCategory as AnyObject,
                                               "event_action": ButtonEventData.eventAction as AnyObject,
                                               "associated_view": ButtonViewData.screenName as AnyObject])
    }

    @objc func addToCart(_ sender: UIButton) {
        TealiumHelper.trackEvent(CartEventData.tealiumEventCartAdd, dataSources: DefaultData.productData)
    }

    @objc func removeFromCart(_ sender: UIButton) {
        TealiumHelper.trackEvent(CartEventData.tealiumEventCartRemove, dataSources: DefaultData.productData)
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
