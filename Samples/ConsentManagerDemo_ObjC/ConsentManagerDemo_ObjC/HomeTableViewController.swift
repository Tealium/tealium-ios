//
//  HomeTableViewController.swift
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 5/25/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    let consentManager = TealiumHelper.sharedInstance().tealium.consentManager
    var consentStatusText = ""
    var consentedCategoriesText = ""
    let consentFont = UIFont.italicSystemFont(ofSize: 15.0)
    let padding: CGFloat = 8.0
    let paddingCount: CGFloat = 3.0
    let consentPreferencesCount = 3
    
    @IBOutlet weak var consentLoggingSwitch: UISwitch!
    
    enum Section: Int {
        case track
        case consentPreferences
        case reset
        case logging
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateConsentStatusView()
        updateConsentLoggingSwitch()
        
        tableView.reloadData()
    }
    
    func updateConsentStatusView() {
        let consentStatusString = TEALConsentManager.consentStatusString(consentManager.userConsentStatus)
        consentStatusText = "Consent Status: \(consentStatusString)"
        
        if let categories = consentManager.userConsentCategories() as? [String] {
            consentedCategoriesText = "Consented Categories: \(categories.joined(separator: ", "))"
        } else {
            consentedCategoriesText = "Consented Categories:"
        }
    }
    
    func updateConsentLoggingSwitch() {
        consentLoggingSwitch.isOn = consentManager.isConsentLoggingEnabled()
    }

    @IBAction func onConsentLoggingChanged(_ sender: UISwitch) {
        if sender.isOn {
            consentManager.setConsentLoggingEnabled(true)
        } else {
            consentManager.setConsentLoggingEnabled(false)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section.track.rawValue {
            return 1
        } else if section == Section.consentPreferences.rawValue {
            return consentPreferencesCount
        } else if section == Section.reset.rawValue {
            return 1
        } else if section == Section.logging.rawValue {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Section.track.rawValue {
            TealiumHelper.trackEvent(withTitle: "HomeTableViewController", dataSources: ["consent_demo": "123"])
        } else if indexPath.section == Section.reset.rawValue {
            consentManager.resetUserConsentPreferences()
            
            updateConsentStatusView()  
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == Section.track.rawValue {
            let footerView = UIView(frame: tableView.frame)
            
            let consentLabel = UILabel(frame: footerView.frame)
            consentLabel.numberOfLines = 0
            consentLabel.lineBreakMode = .byWordWrapping
            consentLabel.font = consentFont
            consentLabel.text = consentStatusText
            consentLabel.textColor = UIColor.darkGray
            consentLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let categoriesLabel = UILabel(frame: footerView.frame)
            categoriesLabel.numberOfLines = 0
            categoriesLabel.lineBreakMode = .byWordWrapping
            categoriesLabel.font = consentFont
            categoriesLabel.text = consentedCategoriesText
            categoriesLabel.textColor = UIColor.darkGray
            categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
            
            var height = labelHeight(text: consentStatusText, font: consentFont)
            height += labelHeight(text: consentedCategoriesText, font: consentFont)
            footerView.frame.size.height = height + paddingCount * padding
            
            footerView.addSubview(consentLabel)
            footerView.addSubview(categoriesLabel)

            var allConstraints: [NSLayoutConstraint] = []
            
            let metrics = [
                "padding": padding
            ]
            let views: [String: Any] = [
                "footerView": footerView,
                "consentLabel": consentLabel,
                "categoriesLabel": categoriesLabel
            ]

            allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[consentLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
            allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[consentLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
            allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[categoriesLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
            allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[consentLabel]-[categoriesLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
            
            NSLayoutConstraint.activate(allConstraints)
            
            return footerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == Section.track.rawValue {
            return labelHeight(text: consentStatusText, font: consentFont) +
                labelHeight(text: consentedCategoriesText, font: consentFont) +
                paddingCount * padding
        } else {
            return 0
        }
    }
    
    func labelHeight(text: String, font: UIFont) -> CGFloat {
        let label = UILabel(frame: view.frame)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.size.height
    }
}
