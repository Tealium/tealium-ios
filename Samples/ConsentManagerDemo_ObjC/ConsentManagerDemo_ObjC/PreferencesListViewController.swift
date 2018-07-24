//
//  PreferencesListViewController.swift
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 5/25/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import UIKit

class PreferencesListViewController: UITableViewController {

    let consentManager = TealiumHelper.sharedInstance().tealium.consentManager
    var titles = [String]()
    var preferences = [Preference]()
    var filteredCategoryNames = [String]()
    var categoryIndexPaths = [IndexPath]()
    let consentStatusString = "Consent Status"
    
    enum ConsentRow: Int {
        case status
        case categories
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPreferences()
        setupTitles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTitles() {
        let consentStatusString = TEALConsentManager.consentStatusString(consentManager.userConsentStatus)
        titles.append("Consent Status: \(consentStatusString)")
        filterCategoryNames()
        titles.append("Current categories: \(filteredCategoryNames.joined(separator: ", "))")
    }
    
    func filterCategoryNames() {
        filteredCategoryNames = preferences.filter { preference in
            preference.enabled == true && !preference.categoryName.isEmpty
            }.map { p in
                return p.categoryName
        }
        if filteredCategoryNames.count > 0 {
            consentManager.setUserConsentStatus(TEALConsentStatus.Consented, withUserConsentCategories: filteredCategoryNames)
        }
    }
    
    func setupPreferences() {
        let consentedCategoryNames = consentManager.userConsentCategories() as? [String]
        
        preferences.append(Preference(name: consentStatusString, enabled: consentManager.isConsented(), helpText: "We would like to collect data about your app experience to help us improve our products. Please choose your preferences.", categoryName: ""))
        
        preferences.append(Preference(name: "Analytics", enabled: consentedCategoryNames?.contains("analytics") ?? false, helpText: "Help us improve your experience.", categoryName: "analytics"))
        preferences.append(Preference(name: "Affiliates", enabled: consentedCategoryNames?.contains("affiliates") ?? false, helpText: "Earn credit for shopping with us.", categoryName: "affiliates"))
        preferences.append(Preference(name: "Display Ads", enabled: consentedCategoryNames?.contains("display_ads") ?? false, helpText: "Help us improve the ads you see.", categoryName: "display_ads"))
        preferences.append(Preference(name: "Email", enabled: consentedCategoryNames?.contains("email") ?? false, helpText: "Allows email marketing tools.", categoryName: "email"))
        preferences.append(Preference(name: "Personalization", enabled: consentedCategoryNames?.contains("personalization") ?? false, helpText: "Let us tailor your app experience.", categoryName: "personalization"))
        preferences.append(Preference(name: "Search", enabled: consentedCategoryNames?.contains("search") ?? false, helpText: "Helps optimize search results.", categoryName: "search"))
        preferences.append(Preference(name: "Social", enabled: consentedCategoryNames?.contains("social") ?? false, helpText: "Social media advertising.", categoryName: "social"))
        preferences.append(Preference(name: "Big Data", enabled: consentedCategoryNames?.contains("big_data") ?? false, helpText: "Helps us better understand our customers.", categoryName: "big_data"))
        preferences.append(Preference(name: "Mobile", enabled: consentedCategoryNames?.contains("mobile") ?? false, helpText: "Optimizes your mobile experience.", categoryName: "mobile"))
        preferences.append(Preference(name: "Engagement", enabled: consentedCategoryNames?.contains("engagement") ?? false, helpText: "Keep in touch with us.", categoryName: "engagement"))
        preferences.append(Preference(name: "Monitoring", enabled: consentedCategoryNames?.contains("monitoring") ?? false, helpText: "Lets us know when things are broken.", categoryName: "monitoring"))
        preferences.append(Preference(name: "CDP", enabled: consentedCategoryNames?.contains("cdp") ?? false, helpText: "Helps us understand your individual needs.", categoryName: "cdp"))
        preferences.append(Preference(name: "CRM", enabled: consentedCategoryNames?.contains("crm") ?? false, helpText: "Helps us keep track of your purchase history.", categoryName: "crm"))
        preferences.append(Preference(name: "Cookie Match", enabled: consentedCategoryNames?.contains("cookiematch") ?? false, helpText: "Required for personalized ads.", categoryName: "cookiematch"))
        preferences.append(Preference(name: "Misc", enabled: consentedCategoryNames?.contains("misc") ?? false, helpText: "Misc items that help us build a better app experience.", categoryName: "misc"))
        
        for row in 1...preferences.count - 1 {
            categoryIndexPaths.append(IndexPath(row: row, section: ConsentSection.settings.rawValue))
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == ConsentSection.status.rawValue {
            return 2
        } else if section == ConsentSection.settings.rawValue {
            return preferences.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == ConsentSection.status.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            let title = titles[indexPath.row]
            cell.title = title
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell") as! SwitchTableViewCell
            let preference = preferences[indexPath.row]
            cell.preference = preference
            cell.enabled.addTarget(self, action: #selector(onSwitchChanged(_:)), for: .valueChanged)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func onSwitchChanged(_ sender: UISwitch) {
        guard let cell = sender.superview?.superview as? SwitchTableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return
        }

        let preference = preferences[indexPath.row]
        preference.enabled = sender.isOn
        
        if preference.name == consentStatusString {
            if preference.enabled {
                consentManager.setUserConsentStatus(TEALConsentStatus.Consented)
            } else {
                consentManager.setUserConsentStatus(TEALConsentStatus.NotConsented)
            }
            
            // logic to enable/disable all switches when master consent status switch is enabled/disabled
            preferences.forEach { p in
                p.enabled = sender.isOn
            }
            
            updateConsentStatusLabel()
            updateConsentCategoriesLabel()
            tableView.reloadRows(at: categoryIndexPaths, with: .automatic)
        } else {
            if preference.enabled {
                // Update master consent status switch when any other row is selected if not enabled
                if !consentManager.isConsented() {
                    preferences.first?.enabled = true
                    tableView.reloadRows(at: [IndexPath(row: 0, section: ConsentSection.settings.rawValue)], with: .automatic)
                }
            }
            updateConsentCategoriesLabel()
            updateConsentStatusLabel()
        }
    }
    
    func updateConsentStatusLabel() {
        let consentStatusString = TEALConsentManager.consentStatusString(consentManager.userConsentStatus)
        titles[ConsentRow.status.rawValue] = "Consent Status: \(consentStatusString)"
        tableView.reloadRows(at: [IndexPath(row: ConsentRow.status.rawValue, section: ConsentSection.status.rawValue)], with: .automatic)
    }
    
    func updateConsentCategoriesLabel() {
        filterCategoryNames()
        titles[ConsentRow.categories.rawValue] = "Current categories: \(filteredCategoryNames.joined(separator: ", "))"
        tableView.reloadRows(at: [IndexPath(row: ConsentRow.categories.rawValue, section: ConsentSection.status.rawValue)], with: .automatic)
    }
}
