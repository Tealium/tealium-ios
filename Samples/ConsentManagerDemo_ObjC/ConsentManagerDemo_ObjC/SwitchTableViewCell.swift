//
//  SwitchTableViewCell.swift
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 6/12/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enabled: UISwitch!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var preference: Preference? {
        didSet {
            titleLabel.text = preference?.name
            enabled.isOn = preference?.enabled ?? false
            descriptionLabel.text = preference?.helpText
        }
    }
}
