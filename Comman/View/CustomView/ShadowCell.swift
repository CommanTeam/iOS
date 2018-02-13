//
//  ShadowCell.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 2..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import UIKit

class ShadowCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if self.tag == 8369 {
            self.layer.cornerRadius = 4.0
        } 
        self.layoutSubviews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(rect : self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.10
        self.layer.shadowPath = shadowPath.cgPath
    }
}


