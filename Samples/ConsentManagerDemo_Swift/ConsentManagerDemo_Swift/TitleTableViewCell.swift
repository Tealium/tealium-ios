//
//  TitleTableViewCell.swift
//  ConsentManagerDemo_ObjC
//
//  Created by Jonathan Wong on 6/12/18.
//  Copyright © 2018 Tealium. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

}
