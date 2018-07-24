//
//  Preference.swift
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 6/13/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import Foundation

/**
 Model class to help with UI mappings.
 */
class Preference {
    let name: String
    var enabled: Bool
    let helpText: String
    let categoryName: String
    
    init(name: String, enabled: Bool, helpText: String, categoryName: String) {
        self.name = name
        self.enabled = enabled
        self.helpText = helpText
        self.categoryName = categoryName
    }
}
