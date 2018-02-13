//
//  CustomTabBarItem.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class CustomTabBarItem: UITabBarItem {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -4, right: 0)
    }
}
