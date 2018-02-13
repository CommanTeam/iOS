//
//  CircleImageView.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 28..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import Foundation
import UIKit

class CircleImageView : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if self.tag == 68 {
            self.frame = CGRect(x: 80, y: 80, width: 80, height: 80)
            self.clipsToBounds = true
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.init(hexString: "#4777D9").cgColor
            self.layer.cornerRadius = self.frame.size.width/2.0
        } else if self.tag == 72 {
            self.frame = CGRect(x: 60, y: 60, width: 60, height: 60)
            self.clipsToBounds = true
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.init(hexString: "#4777D9").cgColor
            self.layer.cornerRadius = self.frame.size.width/2.0
        } else {
            self.frame = CGRect(x: 56, y: 56, width: 56, height: 56)
            self.clipsToBounds = true
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.init(hexString: "#4777D9").cgColor
            self.layer.cornerRadius = self.frame.size.width/2.0
        }
    }
}
