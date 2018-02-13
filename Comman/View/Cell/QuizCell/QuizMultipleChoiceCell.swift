//
//  MultipleChoiceCell.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 1..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import UIKit

class QuizMultipleChoiceCell : UITableViewCell {
    var check: Bool = false
    var multipleChoiceDefaultBgViewColor: UIColor = UIColor.white
    var multipleChoiceSelectBgViewColor: UIColor = UIColor.init(hexString: "#4777D9")
    var multipleChoiceDefaultTextColor: UIColor = UIColor.init(hexString: "3D3D3D")
    var multipleChoiceSelectTextColor: UIColor = UIColor.white
    @IBOutlet weak var multipleChoiceNumLabel: UILabel!
    @IBOutlet weak var multipleChoiceNumTagLabel: UILabel!
    @IBOutlet weak var multipleChoiceContentLabel: UILabel!
    @IBOutlet weak var multipleChoiceView: UIView!
}
