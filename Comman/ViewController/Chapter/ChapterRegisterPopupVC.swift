//
//  ChapterRegisterPopupVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class ChapterRegisterPopupVC: UIViewController, NetworkCallback {
    @IBOutlet weak var popUpInnerView: UIView!
    
    let userDefaults = UserDefaults.standard
    
    var courseID: Int = 0
    var baseNetworkModel: MyCourseNetworkModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseNetworkModel = MyCourseNetworkModel(self)
        popUpInnerView.addInnerShadow(onSide: .bottom, shadowColor: .black, shadowSize: 10.0, shadowOpacity: 0.15)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "registerCourse" {
            guard let parentVC = self.parent as? ChapterVC else {
                return
            }
            parentVC.registerCheck = true
            let alert = UIAlertController(title: "강좌 등록", message: "강좌 등록에 성공하였습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let token = userDefaults.string(forKey: "token")
        baseNetworkModel.registerCourse(token: token!, courseID: self.courseID)
    }
    
    @IBAction func popUpCloseBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func outerViewTapGesture(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
