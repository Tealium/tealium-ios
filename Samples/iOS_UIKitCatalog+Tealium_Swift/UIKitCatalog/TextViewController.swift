/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use UITextView.
*/

import UIKit

class TextViewController: UIViewController, UITextViewDelegate {

    // MARK: Properties
    enum TextViewData {
        static let tealiumEvent = "screen_view"
        static let screenName = "text view"
    }
    @IBOutlet weak var textView: UITextView!
    /// Used to adjust the text view's height when the keyboard hides and shows.
    @IBOutlet weak var textViewBottomLayoutGuideConstraint: NSLayoutConstraint!

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TealiumHelper.trackView(TextViewData.tealiumEvent,
                                dataSources: ["screen_name": TextViewData.screenName as AnyObject])
        configureTextView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Listen for changes to keyboard visibility so that we can adjust the text view accordingly.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(TextViewController.handleKeyboardNotification(_:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(TextViewController.handleKeyboardNotification(_:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Keyboard Event Notifications

    @objc func handleKeyboardNotification(_ notification: Notification) {
        let userInfo = notification.userInfo!
        guard let keyboardAnimationDurationUserInfoKey = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
            else {
                return
        }
        guard let keyboardFrameBeginUserInfoKey = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        // Get information about the animation.
        let animationDuration: TimeInterval = keyboardAnimationDurationUserInfoKey.doubleValue
        let rawAnimationCurveValue = keyboardAnimationDurationUserInfoKey.uintValue
        let animationCurve = UIView.AnimationOptions(rawValue: rawAnimationCurveValue)
        // Convert the keyboard frame from screen to view coordinates.
        let keyboardScreenBeginFrame = keyboardFrameBeginUserInfoKey.cgRectValue
        let keyboardScreenEndFrame = keyboardFrameBeginUserInfoKey.cgRectValue
        let keyboardViewBeginFrame = view.convert(keyboardScreenBeginFrame, from: view.window)
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let originDelta = keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y
        // The text view should be adjusted, update the constant for this constraint.
        textViewBottomLayoutGuideConstraint.constant -= originDelta
        // Inform the view that its autolayout constraints have changed and the layout should be updated.
        view.setNeedsUpdateConstraints()
        // Animate updating the view's layout by calling layoutIfNeeded inside a UIView animation block.
        let animationOptions: UIView.AnimationOptions = [animationCurve, .beginFromCurrentState]
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationOptions, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        // Scroll to the selected text once the keyboard frame changes.
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }

    // MARK: Configuration
    func configureTextView() {
        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.body)
        textView.font = UIFont(descriptor: bodyFontDescriptor, size: 0)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isScrollEnabled = true
        /*
            Let's modify some of the attributes of the attributed string.
            You can modify these attributes yourself to get a better feel for what they do.
            Note that the initial text is visible in the storyboard.
        */
        let attributedText = NSMutableAttributedString(attributedString: textView.attributedText!)
        /*
            Use NSString so the result of rangeOfString is an NSRange, not Range<String.Index>.
            This will then be the correct type to then pass to the addAttribute method of
            NSMutableAttributedString.
        */
        let text = textView.text! as NSString
        // Find the range of each element to modify.
        let boldRange = text.range(of: NSLocalizedString("bold", comment: ""))
        let highlightedRange = text.range(of: NSLocalizedString("highlighted", comment: ""))
        let underlinedRange = text.range(of: NSLocalizedString("underlined", comment: ""))
        let tintedRange = text.range(of: NSLocalizedString("tinted", comment: ""))
        /*
            Add bold. Take the current font descriptor and create a new font descriptor
            with an additional bold trait.
        */
        let boldFontDescriptor = textView.font!.fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont = UIFont(descriptor: boldFontDescriptor!, size: 0)
        attributedText.addAttribute(NSAttributedString.Key.font, value: boldFont, range: boldRange)

        // Add highlight.
        attributedText.addAttribute(NSAttributedString.Key.backgroundColor,
                                    value: UIColor.applicationGreenColor,
                                    range: highlightedRange)
        // Add underline.
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: underlinedRange)
        // Add tint.
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.applicationBlueColor,
                                    range: tintedRange)
        // Add image attachment.
        let textAttachment = NSTextAttachment()
        let image = UIImage(named: "text_view_attachment")!
        textAttachment.image = image
        textAttachment.bounds = CGRect(origin: CGPoint.zero, size: image.size)
        let textAttachmentString = NSAttributedString(attachment: textAttachment)
        attributedText.append(textAttachmentString)
        textView.attributedText = attributedText
    }

    // MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        /*
            Provide a "Done" button for the user to select to signify completion 
            with writing text in the text view.
        */
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                target: self,
                                                action: #selector(TextViewController.doneBarButtonItemClicked))
        navigationItem.setRightBarButton(doneBarButtonItem, animated: true)
    }

    // MARK: Actions
    @objc func doneBarButtonItemClicked() {
        // Dismiss the keyboard by removing it as the first responder.
        textView.resignFirstResponder()
        navigationItem.setRightBarButton(nil, animated: true)
    }
}
