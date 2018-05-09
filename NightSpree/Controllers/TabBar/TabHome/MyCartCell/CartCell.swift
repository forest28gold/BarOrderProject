//
//  CartCell.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/14/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak var placeDesLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeDesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var taxBeforePriceLabel: UILabel!
    @IBOutlet weak var taxDesLabel: UILabel!
    @IBOutlet weak var taxPriceLabel: UILabel!
    @IBOutlet weak var subTotalPriceLabel: UILabel!
    @IBOutlet weak var tip0Button: UIButton!
    @IBOutlet weak var tip1Button: UIButton!
    @IBOutlet weak var tip2Button: UIButton!
    @IBOutlet weak var tip3Button: UIButton!
    @IBOutlet weak var tipPriceLabel: UILabel!
    @IBOutlet weak var glassView: UIView!
    @IBOutlet weak var glassViewHeight: NSLayoutConstraint!
    @IBOutlet weak var totalPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
