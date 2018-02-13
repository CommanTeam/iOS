//
//  CustomProgressBar.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class CustomProgressBar: UIProgressView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        switch self.tag {
        case 7765:
            self.transform = self.transform.scaledBy(x: 1.0, y: 3.0)
            break
        default:
            self.transform = self.transform.scaledBy(x: 1.0, y: 5.0)
            break
        }
    }
}
