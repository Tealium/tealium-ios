//
//  ViewController.swift
//  RemoteCommandSurvey
//
//  Created by Jonathan Wong on 5/22/19.
//  Copyright © 2019 Jonathan Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TealiumHelper.trackView(with: "viewcontroller", dataSources: ["foo": "bar"])
        
        addShowSurveyCommand()
    }

    @IBAction func trackButtonPressed(_ sender: Any) {
        TealiumHelper.trackEvent(with: "button_pressed", dataSources: nil)
    }
    
    @IBAction func cartCheckoutPressed(_ sender: Any) {
        TealiumHelper.trackEvent(with: "cart_checkout", dataSources: nil)
    }
    
    func addShowSurveyCommand() {
        TealiumHelper.shared.tealium.addRemoteCommandID("showSurvey",
                                   description: "Show custom survey",
                                   targetQueue: DispatchQueue.main,
                                   responseBlock: { response in
                                    guard let title = response.requestPayload["survey_title"] as? String else {
                                        return
                                    }
                                    let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                        
                                    }))
                                    self.present(alert, animated: true)
        })
    }
}

