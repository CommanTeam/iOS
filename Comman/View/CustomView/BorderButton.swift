//
//  BorderButton.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 2..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import UIKit

class BorderButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(hexString : "#4777D9").cgColor
        self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(rect : self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowPath = shadowPath.cgPath
    }
}
