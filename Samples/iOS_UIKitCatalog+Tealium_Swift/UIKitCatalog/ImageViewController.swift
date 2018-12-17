/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use UIImageView.
*/

import UIKit

class ImageViewController: UIViewController {

    // MARK: Properties
    enum ImageViewData {
        static let tealiumEvent = "checkout"
        static let screenName = "checkout view"
    }
    var checkoutData = [[String: AnyObject]]()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutData.append(DefaultData.productData)
        checkoutData.append(DefaultData.customerData)
        var data = DefaultData.mergeDataDictionaries(with: checkoutData)
        data["screen_name"] = ImageViewData.screenName as AnyObject
        TealiumHelper.trackView(ImageViewData.tealiumEvent,
                                dataSources: data)
        configureImageView()
    }

    // MARK: Configuration
    func configureImageView() {
        // The root view of the view controller set in Interface Builder is a UIImageView.
        guard let imageView = view as? UIImageView else {
            return
        }
        // Fetch the images (each image is of the format image_animal_number).        
        imageView.animationImages = (1...5).map { UIImage(named: "image_animal_\($0)")! }
        // We want the image to be scaled to the correct aspect ratio within imageView's bounds.
        imageView.contentMode = .scaleAspectFit
        /*
            If the image does not have the same aspect ratio as imageView's bounds, 
            then imageView's backgroundColor will be applied to the "empty" space.
        */
        imageView.backgroundColor = UIColor.white
        imageView.animationDuration = 5
        imageView.startAnimating()
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = NSLocalizedString("Animated", comment: "")
    }
}
