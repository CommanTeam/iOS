//
//  QuizMainVC.swift
//  Comman
//
//  Created by 김지우 on 2017. 12. 31..
//  Copyright © 2017년 havetherain. All rights reserved.
//

import Foundation
import UIKit

class QuizMainVC : UIViewController, NetworkCallback {
    let userDefaults = UserDefaults.standard
    
    var token: String = ""
    var lectureID: Int = 0
    var baseNetworkModel: LectureNetworkModel!
    var quizInfoList: [QuizInfoVO] = [QuizInfoVO]()

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBeforeLabel: UILabel!
    @IBOutlet weak var tabBeforeBtn: UIView!
    
    @IBOutlet weak var tabNextLabel: UILabel!
    @IBOutlet weak var tabNextBtn: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseNetworkModel = LectureNetworkModel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userDefaults.set(lectureID, forKey: "lectureID")
        self.token = userDefaults.string(forKey: "token")!
        baseNetworkModel.setUserLectureHistory(token: self.token, lectureID: self.lectureID)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "1-1" {
        }
    }
    
    @objc func tapBeforeAction(_ sender: UIView) {
        
    }
    @objc func tapNextAction(_ sender: UIView) {
        
    }
}
