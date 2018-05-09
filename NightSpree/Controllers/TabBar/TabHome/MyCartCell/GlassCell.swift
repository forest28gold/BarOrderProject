//
//  GlassCell.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/14/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class GlassCell: UITableViewCell {
    
    @IBOutlet weak var glassImage: UIImageView!
    @IBOutlet weak var glassCountView: UIView!
    @IBOutlet weak var glassCountLabel: UILabel!
    @IBOutlet weak var glassNameLabel: UILabel!
    @IBOutlet weak var glassUnitPriceLabel: UILabel!
    @IBOutlet weak var glassTotalPriceLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
