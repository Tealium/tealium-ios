//
//  ConsentGroup.swift
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 6/13/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import Foundation

/**
 Model struct to help with UI mappings.
 */
struct ConsentGroup {
    let name: String
    let categories: [String]
}

enum ConsentSection: Int {
    case status
    case settings
}
