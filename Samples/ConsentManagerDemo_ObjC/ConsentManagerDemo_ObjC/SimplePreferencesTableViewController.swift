//
//  SimplePreferencesTableViewController.swift
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 5/25/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import UIKit

class SimplePreferencesTableViewController: UITableViewController {

    @IBOutlet weak var consentStatusLabel: UILabel!
    @IBOutlet weak var consentedCategoriesLabel: UILabel!
    @IBOutlet weak var consentStatusSwitch: UISwitch!
    
    let consentManager = TealiumHelper.sharedInstance().tealium.consentManager
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateConsentStatusLabel()
        updateConsentStatus()
        updateConsentedCategoriesLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == ConsentSection.status.rawValue {
            return 2
        } else if section == ConsentSection.settings.rawValue {
            return 1
        } else {
            return 0
        }
    }
    
    func updateConsentStatusLabel() {
        let consentStatusString = TEALConsentManager.consentStatusString(consentManager.userConsentStatus)
        consentStatusLabel.text = "Consent Status: \(consentStatusString)"
    }

    func updateConsentStatus() {
        if consentManager.userConsentStatus == TEALConsentStatus.Consented {
            consentStatusSwitch.isOn = true
        } else {
            consentStatusSwitch.isOn = false
        }
    }
    
    func updateConsentedCategoriesLabel() {
        if consentManager.userConsentStatus == TEALConsentStatus.Consented {
            guard let consentedCategoryNames = consentManager.userConsentCategories() as? [String] else {
                return
            }
            
            consentedCategoriesLabel.text = "Current Categories: \(consentedCategoryNames.joined(separator: ", "))"
        } else {
            consentedCategoriesLabel.text = "Current Categories: "
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func onConsentStatusSwitchChange(_ sender: UISwitch) {
        let enabled = sender.isOn
        
        if enabled {
            consentManager.setUserConsentStatus(TEALConsentStatus.Consented)
        } else {
            consentManager.setUserConsentStatus(TEALConsentStatus.NotConsented)
        }
        
        updateConsentStatusLabel()
        updateConsentedCategoriesLabel()
    }
}
