//
//  BackCardView.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 28..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import Foundation
import UIKit

class BackView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        switch self.tag {
        case 67:
            self.layer.addBorder([.bottom], color: UIColor.init(hexString : "#CBCBCB"), width: 1.0)
            break
        case 79, 87, 6752:
            self.layer.cornerRadius = 4
            break
        case 76, 86:
            break
        default:
            self.layer.cornerRadius = 4
            self.layer.addBorder([.all], color: UIColor.init(hexString : "#828282"), width: 1.0)
            break
        }
        layoutSubviews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.tag == 6752 {
            let shadowPath = UIBezierPath(rect : self.bounds)
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.init(hexString: "#E4E4E4").cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowOpacity = 0.8
            self.layer.shadowPath = shadowPath.cgPath
        } else if self.tag == 6783 {
            let shadowPath = UIBezierPath(rect : self.bounds)
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.layer.shadowOpacity = 0.15
            self.layer.shadowPath = shadowPath.cgPath
        } else if self.tag == 6787 || self.tag == 79 || self.tag == 86 {
            let shadowPath = UIBezierPath(rect : self.bounds)
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.layer.shadowOpacity = 0.15
            self.layer.shadowPath = shadowPath.cgPath
        } else if self.tag == 76 {
            self.addInnerShadow(onSide: .left, shadowColor: .black, shadowSize: 2.0, shadowOpacity: 0.15)
        }
    }
}
