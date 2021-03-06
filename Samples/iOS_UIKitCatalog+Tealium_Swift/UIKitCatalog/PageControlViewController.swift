/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use UIPageControl.
*/

import UIKit

class PageControlViewController: UIViewController {

    // MARK: Properties
    enum PageControlViewData {
        static let tealiumEvent = "purchase"
        static let screenName = "order confirmation view"
    }
    var orderData = [[String: AnyObject]]()
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var colorView: UIView!

    /// Colors that correspond to the selected page. Used as the background color for `colorView`.
    let colors = [
        UIColor.black,
        UIColor.gray,
        UIColor.red,
        UIColor.green,
        UIColor.blue,
        UIColor.cyan,
        UIColor.yellow,
        UIColor.magenta,
        UIColor.orange,
        UIColor.purple
    ]

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        orderData.append(DefaultData.productData)
        orderData.append(DefaultData.customerData)
        orderData.append(DefaultData.orderData)
        var data = DefaultData.mergeDataDictionaries(with: orderData)
        data["screen_name"] = PageControlViewData.screenName as AnyObject
        TealiumHelper.trackView(PageControlViewData.tealiumEvent,
                                dataSources: data)
        configurePageControl()
        pageControlValueDidChange()
    }

    // MARK: Configuration
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl.numberOfPages = colors.count
        pageControl.currentPage = 2
        pageControl.tintColor = UIColor.applicationBlueColor
        pageControl.pageIndicatorTintColor = UIColor.applicationGreenColor
        pageControl.currentPageIndicatorTintColor = UIColor.applicationPurpleColor
        pageControl
            .addTarget(self,
                       action: #selector(PageControlViewController.pageControlValueDidChange),
                       for: .valueChanged)
    }

    // MARK: Actions
    @objc func pageControlValueDidChange() {
        NSLog("The page control changed its current page to \(pageControl.currentPage).")
        colorView.backgroundColor = colors[pageControl.currentPage]
    }
}
