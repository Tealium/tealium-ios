//
//  ViewController.swift
//  WatchOS_Sample_Swift
//
//  Created by Jonathan Wong on 3/19/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TealiumHelper.trackViewWithTitle(title: "ViewController.view", dataSources: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

