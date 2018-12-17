/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use UIStackView.
*/

import UIKit

class StackViewController: UIViewController {

    // MARK: Properties
    enum StackViewData {
        static let tealiumEvent = "screen_view"
        static let screenName = "stack view"
    }
    @IBOutlet var furtherDetailStackView: UIStackView!
    @IBOutlet var plusButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        TealiumHelper.trackView(StackViewData.tealiumEvent,
                                dataSources: ["screen_name": StackViewData.screenName as AnyObject])
    }

    // MARK: View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        furtherDetailStackView.isHidden = true
        plusButton.isHidden = false
    }

    // MARK: Actions
    @IBAction func showFurtherDetail(_: AnyObject) {
        // Animate the changes by performing them in a `UIView` animation block.
        UIView.animate(withDuration: 0.25, animations: {
            // Reveal the further details stack view and hide the plus button.
            self.furtherDetailStackView.isHidden = false
            self.plusButton.isHidden = true
        })
    }

    @IBAction func hideFurtherDetail(_: AnyObject) {
        // Animate the changes by performing them in a `UIView` animation block.
        UIView.animate(withDuration: 0.25, animations: {
            // Hide the further details stack view and reveal the plus button.
            self.furtherDetailStackView.isHidden = true
            self.plusButton.isHidden = false
        })
    }
}
