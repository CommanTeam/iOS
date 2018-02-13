//
//  CustomSwitch.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 8..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class CustomSwitch: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 28.0, height: 12.0)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
