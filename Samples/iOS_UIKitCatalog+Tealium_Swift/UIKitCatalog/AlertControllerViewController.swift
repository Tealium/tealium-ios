/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The view controller that demonstrates how to use UIAlertController.
*/

import UIKit

class AlertControllerViewController: UITableViewController {

    // MARK: Properties
    enum AlertViewData {
        static let tealiumEvent = "form_view"
        static let screenName = "alert controller view"
    }
    enum AlertEventData {
        static let tealiumEvent = "button_click"
        static let eventCategory = "alerts"
        static let eventAction = "click"
    }
    enum EmailSignupEventData {
        static let tealiumEvent = "email_signup"
        static let eventCategory = "newsletter submit"
        static let eventAction = "lead generation"
    }
    weak var secureTextAlertAction: UIAlertAction?
    /*
        A matrix of closures that should be invoked based on which table view
        cell is tapped (index by section, row).
    */
    var actionMap: [[(_ selectedIndexPath: IndexPath) -> Void]] {
        return [
            // Alert style alerts.
            [
                showSimpleAlert,
                showOkayCancelAlert,
                showOtherAlert,
                showTextEntryAlert,
                showSecureTextEntryAlert
            ],
            // Action sheet style alerts.
            [
                showOkayCancelActionSheet,
                showOtherActionSheet
            ]
        ]
    }

    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        TealiumHelper.trackView(AlertViewData.tealiumEvent,
                                dataSources: ["screen_name": AlertViewData.screenName as AnyObject])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func trackAlertEvent(buttonName: String) {
        TealiumHelper.trackEvent(AlertEventData.tealiumEvent,
                                 dataSources: ["event_label": buttonName as AnyObject,
                                               "event_category": AlertEventData.eventCategory as AnyObject,
                                               "event_action": AlertEventData.eventAction as AnyObject,
                                               "associated_view": AlertViewData.screenName as AnyObject])
    }

    func trackEmailSignup(buttonName: String, email: String) {
        TealiumHelper.trackEvent(EmailSignupEventData.tealiumEvent,
                                 dataSources: ["event_label": buttonName as AnyObject,
                                               "event_category": EmailSignupEventData.eventCategory as AnyObject,
                                               "event_action": EmailSignupEventData.eventAction as AnyObject,
                                               "customer_email": email as AnyObject,
                                               "associated_view": AlertViewData.screenName as AnyObject])
    }

    // MARK: UIAlertControllerStyleAlert Style Alerts
    /// Show an alert with an "Okay" button.
    func showSimpleAlert(_: IndexPath) {
        let title = NSLocalizedString("A Short Title is Best", comment: "")
        let message = NSLocalizedString("A message should be a short, complete sentence.", comment: "")
        let cancelButtonTitle = NSLocalizedString("OK", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create the action.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            NSLog("The simple alert's cancel action occured.")
            self.trackAlertEvent(buttonName: cancelButtonTitle)
        }
        // Add the action.
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    /// Show an alert with an "Okay" and "Cancel" button.
    func showOkayCancelAlert(_: IndexPath) {
        let title = NSLocalizedString("A Short Title is Best", comment: "")
        let message = NSLocalizedString("A message should be a short, complete sentence.", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let otherButtonTitle = NSLocalizedString("OK", comment: "")
        let alertCotroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            NSLog("The \"Okay/Cancel\" alert's cancel action occured.")
            self.trackAlertEvent(buttonName: cancelButtonTitle)
        }
        let otherAction = UIAlertAction(title: otherButtonTitle, style: .default) { _ in
            NSLog("The \"Okay/Cancel\" alert's other action occured.")
            self.trackAlertEvent(buttonName: otherButtonTitle)
        }
        // Add the actions.
        alertCotroller.addAction(cancelAction)
        alertCotroller.addAction(otherAction)
        present(alertCotroller, animated: true, completion: nil)
    }

    /// Show an alert with two custom buttons.
    func showOtherAlert(_: IndexPath) {
        let title = NSLocalizedString("A Short Title is Best", comment: "")
        let message = NSLocalizedString("A message should be a short, complete sentence.", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let otherButtonTitleOne = NSLocalizedString("Choice One", comment: "")
        let otherButtonTitleTwo = NSLocalizedString("Choice Two", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            NSLog("The \"Other\" alert's cancel action occured.")
            self.trackAlertEvent(buttonName: cancelButtonTitle)
        }
        let otherButtonOneAction = UIAlertAction(title: otherButtonTitleOne, style: .default) { _ in
            NSLog("The \"Other\" alert's other button one action occured.")
            self.trackAlertEvent(buttonName: otherButtonTitleOne)
        }
        let otherButtonTwoAction = UIAlertAction(title: otherButtonTitleTwo, style: .default) { _ in
            NSLog("The \"Other\" alert's other button two action occured.")
            self.trackAlertEvent(buttonName: otherButtonTitleTwo)
        }
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(otherButtonOneAction)
        alertController.addAction(otherButtonTwoAction)
        present(alertController, animated: true, completion: nil)
    }

    /// Show a text entry alert with two custom buttons.
    func showTextEntryAlert(_: IndexPath) {
        let title = NSLocalizedString("Email Signup", comment: "")
        let message = NSLocalizedString("Please enter your email address to receive our newsletter.", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let otherButtonTitle = NSLocalizedString("OK", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Add the text field for text entry.
        alertController.addTextField { _ in
            // If you need to customize the text field, you can do so here.
        }
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            NSLog("The \"Text Entry\" alert's cancel action occured.")
            self.trackAlertEvent(buttonName: cancelButtonTitle)
        }
        let otherAction = UIAlertAction(title: otherButtonTitle, style: .default) { _ in
            NSLog("The \"Text Entry\" alert's other action occured.")
            let textField = alertController.textFields![0]
            if let textFieldText = textField.text {
                self.trackEmailSignup(buttonName: otherButtonTitle, email: textFieldText)
            } else {
                self.trackEmailSignup(buttonName: otherButtonTitle, email: "test@example.com")
            }
        }
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        present(alertController, animated: true, completion: nil)
    }
    /// Show a secure text entry alert with two custom buttons.
    func showSecureTextEntryAlert(_: IndexPath) {
        let title = NSLocalizedString("A Short Title is Best", comment: "")
        let message = NSLocalizedString("A message should be a short, complete sentence.", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let otherButtonTitle = NSLocalizedString("OK", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Add the text field for the secure text entry.
        alertController.addTextField { textField in
            /*
                Listen for changes to the text field's text so that we can toggle the current
                action's enabled property based on whether the user has entered a sufficiently
                secure entry.
            */
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(AlertControllerViewController
                                                                        .handleTextFieldTextDidChangeNotification(_:)),
                                                   name: UITextField.textDidChangeNotification,
                                                   object: textField)
            textField.isSecureTextEntry = true
        }
        /*
            Stop listening for text change notifications on the text field. This
            closure will be called in the two action handlers.
        */
        let removeTextFieldObserver: () -> Void = {
            NotificationCenter.default.removeObserver(self,
                                                      name: UITextField.textDidChangeNotification,
                                                      object: alertController.textFields!.first)
        }
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            NSLog("The \"Secure Text Entry\" alert's cancel action occured.")
            self.trackAlertEvent(buttonName: cancelButtonTitle)
            removeTextFieldObserver()
        }
        let otherAction = UIAlertAction(title: otherButtonTitle, style: .default) { _ in
            NSLog("The \"Secure Text Entry\" alert's other action occured.")
            self.trackAlertEvent(buttonName: otherButtonTitle)
            removeTextFieldObserver()
        }
        // The text field initially has no text in the text field, so we'll disable it.
        otherAction.isEnabled = false
        /*
            Hold onto the secure text alert action to toggle the enabled / disabled 
            state when the text changed.
        */
        secureTextAlertAction = otherAction
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: UIAlertControllerStyleActionSheet Style Alerts
    /// Show a dialog with an "Okay" and "Cancel" button.
    func showOkayCancelActionSheet(_ selectedIndexPath: IndexPath) {
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "OK")
        let destructiveButtonTitle = NSLocalizedString("OK", comment: "")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            self.trackAlertEvent(buttonName: cancelButtonTitle)
            NSLog("The \"Okay/Cancel\" alert action sheet's cancel action occured.")
        }
        let destructiveAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive) { _ in
            self.trackAlertEvent(buttonName: destructiveButtonTitle)
            NSLog("The \"Okay/Cancel\" alert action sheet's destructive action occured.")
        }
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(destructiveAction)
        // Configure the alert controller's popover presentation controller if it has one.
        if let popoverPresentationController = alertController.popoverPresentationController {
            // This method expects a valid cell to display from.
            let selectedCell = tableView.cellForRow(at: selectedIndexPath)!
            popoverPresentationController.sourceRect = selectedCell.frame
            popoverPresentationController.sourceView = view
            popoverPresentationController.permittedArrowDirections = .up
        }
        present(alertController, animated: true, completion: nil)
    }

    /// Show a dialog with two custom buttons.
    func showOtherActionSheet(_ selectedIndexPath: IndexPath) {
        let destructiveButtonTitle = NSLocalizedString("Destructive Choice", comment: "")
        let otherButtonTitle = NSLocalizedString("Safe Choice", comment: "")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // Create the actions.
        let destructiveAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive) { _ in
            self.trackAlertEvent(buttonName: destructiveButtonTitle)
            NSLog("The \"Other\" alert action sheet's destructive action occured.")
        }
        let otherAction = UIAlertAction(title: otherButtonTitle, style: .default) { _ in
            self.trackAlertEvent(buttonName: otherButtonTitle)
            NSLog("The \"Other\" alert action sheet's other action occured.")
        }
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(otherAction)
        // Configure the alert controller's popover presentation controller if it has one.
        if let popoverPresentationController = alertController.popoverPresentationController {
            // This method expects a valid cell to display from.
            let selectedCell = tableView.cellForRow(at: selectedIndexPath)!
            popoverPresentationController.sourceRect = selectedCell.frame
            popoverPresentationController.sourceView = view
            popoverPresentationController.permittedArrowDirections = .up
        }
        present(alertController, animated: true, completion: nil)
    }

    // MARK: UITextFieldTextDidChangeNotification
    @objc func handleTextFieldTextDidChangeNotification(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else {
            return
        }
        // Enforce a minimum length of >= 5 characters for secure text alerts.
        if let text = textField.text {
            secureTextAlertAction!.isEnabled = text.count >= 5
        } else {
            secureTextAlertAction!.isEnabled = false
        }
    }

    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = actionMap[indexPath.section][indexPath.row]
        action(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
