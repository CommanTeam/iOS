//
//  QuizRegisterVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 2..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import UIKit
class QuizRegisterVC: UIViewController {
    var pageIndex: Int = 1
    var lectureStr: String = ""
    var condtionStr: String = ""
    
    @IBOutlet weak var pageCountCurNumLabel: UILabel!
    @IBOutlet weak var pageCountAllNumLabel: UILabel!
    @IBOutlet weak var lecTitleLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var registerBtn: BorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lecTitleLabel.text = lectureStr
        conditionLabel.text = condtionStr
    }
}
