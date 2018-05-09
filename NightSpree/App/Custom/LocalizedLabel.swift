//
//  LocalizedLabel.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/6/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation
import UIKit

class LocalizedLabel : UILabel {
    override func awakeFromNib() {
        if let text = text {
            let attributedString = NSMutableAttributedString(string: NSLocalizedString(text, comment: ""))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            self.attributedText = attributedString;
        }
    }
}

class LocalizedCenterLabel : UILabel {
    override func awakeFromNib() {
        if let text = text {
            let attributedString = NSMutableAttributedString(string: NSLocalizedString(text, comment: ""))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.lineSpacing = 4
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            self.attributedText = attributedString;
        }
    }
}
