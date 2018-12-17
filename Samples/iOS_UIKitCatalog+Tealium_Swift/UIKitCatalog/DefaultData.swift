//
//  File.swift
//  UIKitCatalog+Tealium-Swift
//
//  Created by Christina on 12/14/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct DefaultData {

    static var customer_id = "cust1234" as AnyObject
    static var customer_email = "test@example.com" as AnyObject
    static var product_id = ["prod123"] as AnyObject
    static var product_price = ["99.99"] as AnyObject
    static var product_name = ["skinny leggings"] as AnyObject
    static var product_category = ["women\'s"] as AnyObject
    static var product_subcategory = ["jeans"] as AnyObject
    static var product_brand = ["acme"] as AnyObject
    static var product_variant = ["s00"] as AnyObject
    static var product_size = ["small"] as AnyObject
    static var product_quantity = ["1"] as AnyObject
    static var product_sku = ["sl-sm-s00"] as AnyObject
    static var order_id = "testord123" as AnyObject
    static var order_subtotal = "109.98" as AnyObject
    static var order_tax_amount = "4.00" as AnyObject
    static var order_shipping_amount = "5.99" as AnyObject
    static var order_total = "119.97" as AnyObject
    static var customerData = [
        "customer_id": customer_id,
        "customer_email": customer_email
    ]
    static var productData = [
        "product_id": product_id,
        "product_price": product_price,
        "product_name": product_name,
        "product_category": product_category,
        "product_subcategory": product_subcategory,
        "product_variant": product_variant,
        "product_size": product_size,
        "product_quantity": product_quantity,
        "product_sku": product_sku
    ]
    static var orderData = [
        "order_id": order_id,
        "order_subtotal": order_subtotal,
        "order_tax_amount": order_tax_amount,
        "order_shipping_amount": order_shipping_amount,
        "order_total": order_total
    ]

    static func mergeDataDictionaries(with arrayOfDictionaries: [[String: AnyObject]]) -> [String: AnyObject] {
        let flattenedDictionary = arrayOfDictionaries
            .flatMap { $0 }
            .reduce([String: AnyObject]()) { (dict, tuple) in
                var nextDict = dict
                nextDict.updateValue(tuple.1, forKey: tuple.0)
                return nextDict
        }
        return flattenedDictionary
    }

}
