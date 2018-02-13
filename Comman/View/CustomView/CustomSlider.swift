//
//  CustomSlider.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 8..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setThumbImage(UIImage(named: "slider_thumbImg_3"), for: .normal)
        self.setThumbImage(UIImage(named: "slider_thumbImg_3"), for: .highlighted)
    }
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
}
