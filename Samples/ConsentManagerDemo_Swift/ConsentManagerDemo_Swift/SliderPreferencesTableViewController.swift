//
//  SliderPreferencesTableViewController.swift
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 5/29/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import UIKit

class SliderPreferencesTableViewController: UITableViewController {

    @IBOutlet weak var consentStatusLabel: UILabel!
    @IBOutlet weak var consentedCategoriesLabel: UILabel!
    @IBOutlet weak var consentStatusSlider: UISlider!
    @IBOutlet weak var consentLevelLabel: UILabel!
    
    var consentSliderValue: Int = 0
    var consentGroups = [ConsentGroup]()
    
    let consentManager = TealiumHelper.shared.tealium.consentManager
    
    enum ConsentLevels: Int {
        case off
        case performance
        case marketing
        case personalizedAdvertising
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConsentGroups()
        updateConsentStatusSlider()
        updateConsentStatusLabel()
        updateConsentLevelLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConsentGroups() {
        consentGroups.append(ConsentGroup(name: "Off", categories: []))
        consentGroups.append(ConsentGroup(name: "Performance", categories: ["analytics", "monitoring", "big_data", "mobile", "crm"]))
        consentGroups.append(ConsentGroup(name: "Marketing", categories: ["analytics", "monitoring", "big_data", "mobile", "crm", "affiliates", "email", "search", "engagement", "cdp"]))
        consentGroups.append(ConsentGroup(name: "Personalized Advertising", categories: ["analytics", "monitoring", "big_data", "mobile", "crm", "affiliates", "email", "search", "engagement", "cdp", "display_ads", "personalization", "social", "cookiematch", "misc"]))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == ConsentSection.status.rawValue {
            return 2
        } else if section == ConsentSection.settings.rawValue {
            return 2
        } else {
            return 0
        }
    }

    func updateConsentStatusLabel() {
        let consentStatusString = TEALConsentManager.consentStatusString(consentManager.userConsentStatus)
        consentStatusLabel.text = "Consent Status: \(consentStatusString)"
    }
    
    func updateConsentedCategoriesLabel(index: Int) {
        consentedCategoriesLabel.text = "Consent Status: \(consentGroups[index].categories.joined(separator: ", "))"
    }
    
    func updateConsentLevelLabel() {
        if consentSliderValue == ConsentLevels.off.rawValue {
            consentLevelLabel.text = "Consent Level: \(consentGroups[ConsentLevels.off.rawValue].name)"
        } else if consentSliderValue == ConsentLevels.performance.rawValue {
            consentLevelLabel.text = "Consent Level: \(consentGroups[ConsentLevels.performance.rawValue].name)"
        } else if consentSliderValue == ConsentLevels.marketing.rawValue {
            consentLevelLabel.text = "Consent Level: \(consentGroups[ConsentLevels.marketing.rawValue].name)"
        } else if consentSliderValue == ConsentLevels.personalizedAdvertising.rawValue {
            consentLevelLabel.text = "Consent Level: \(consentGroups[ConsentLevels.personalizedAdvertising.rawValue].name)"
        } else {
            consentLevelLabel.text = "Consent Level"
        }
    }
    
    @IBAction func onConsentSliderChange(_ sender: UISlider) {
        let index = Int(sender.value + 0.5)
        sender.setValue(Float(index), animated: false)
        consentSliderValue = index
        
        updateConsent(consentIndex: index)
    }
    
    func updateConsent(consentIndex: Int) {
        switch consentIndex {
        case ConsentLevels.off.rawValue:
            consentManager.setUserConsentStatus(TEALConsentStatus.NotConsented)
        case ConsentLevels.performance.rawValue:
            let categories = consentGroups[ConsentLevels.performance.rawValue].categories
            consentManager.setUserConsentStatus(TEALConsentStatus.Consented, withUserConsentCategories: categories)
        case ConsentLevels.marketing.rawValue:
            let categories = consentGroups[ConsentLevels.marketing.rawValue].categories
            consentManager.setUserConsentStatus(TEALConsentStatus.Consented, withUserConsentCategories: categories)
        case ConsentLevels.personalizedAdvertising.rawValue:
            let categories = consentGroups[ConsentLevels.personalizedAdvertising.rawValue].categories
            consentManager.setUserConsentStatus(TEALConsentStatus.Consented, withUserConsentCategories: categories)
        default:
            consentManager.setUserConsentStatus(TEALConsentStatus.Unknown)
        }

        updateConsentStatusLabel()
        updateConsentLevelLabel()
        updateConsentedCategoriesLabel(index: consentIndex)
    }
    
    func updateConsentStatusSlider() {
        switch consentManager.userConsentStatus {
        case .NotConsented, .Unknown, .Disabled:
            let index = ConsentLevels.off.rawValue
            consentStatusSlider.setValue(Float(index), animated: false)
            consentManager.setUserConsentCategories(consentGroups[index].categories)
                    updateConsentedCategoriesLabel(index: index)
            consentSliderValue = ConsentLevels.off.rawValue
        case .Consented:
            let index = ConsentLevels.personalizedAdvertising.rawValue
            consentStatusSlider.setValue(Float(index), animated: false)
            consentManager.setUserConsentCategories(consentGroups[index].categories)
                    updateConsentedCategoriesLabel(index: index)
            consentSliderValue = index
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
