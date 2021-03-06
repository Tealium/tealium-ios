/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use UIDatePicker.
*/

import UIKit

class DatePickerController: UIViewController {

    // MARK: Properties
    enum DatePickerViewData {
        static let tealiumEvent = "cart_view"
        static let screenName = "cart view"
    }
    var cartData = [[String: AnyObject]]()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!

    /// A date formatter to format the `date` property of `datePicker`.
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cartData.append(DefaultData.productData)
        cartData.append(DefaultData.customerData)
        var data = DefaultData.mergeDataDictionaries(with: cartData)
        data["screen_name"] = DatePickerViewData.screenName as AnyObject
        TealiumHelper.trackView(DatePickerViewData.tealiumEvent,
                                dataSources: data)
        configureDatePicker()
    }

    // MARK: Configuration
    func configureDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        /*
            Set min/max date for the date picker. As an example we will limit the 
            date between now and 7 days from now.
        */
        let now = Date()
        datePicker.minimumDate = now
        let currentCalendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 7
        let sevenDaysFromNow = (currentCalendar as NSCalendar).date(byAdding: dateComponents, to: now, options: [])
        datePicker.maximumDate = sevenDaysFromNow
        datePicker.minuteInterval = 2
        datePicker.addTarget(self, action: #selector(DatePickerController.updateDatePickerLabel), for: .valueChanged)
        updateDatePickerLabel()
    }

    // MARK: Actions
    @objc func updateDatePickerLabel() {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
}
