//
//  LoginVC.swift
//  Comman
//
//  Created by 김지우 on 2017. 12. 31..
//  Copyright © 2017년 havetherain. All rights reserved.
//

import Foundation
import UIKit

class LoginVC : UIViewController, NetworkCallback {
    let userDefaults = UserDefaults.standard
    
    var networkModel: LoginNetworkModel!
    var nickName: String = ""
    var thumbnailPath: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkModel = LoginNetworkModel(self)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "1-1" {
            guard let responseList = resultData as? [String] else {
                return
            }
            self.userDefaults.set(responseList[0], forKey: "token")
            self.userDefaults.set(responseList[1], forKey: "nickname")
            self.userDefaults.set(responseList[2], forKey: "thumbnailPath")

            print("token : " + self.userDefaults.string(forKey: "token")!)
            
            let home_course_storyboard = UIStoryboard(name: "Home", bundle: nil)
            guard let mainTBC = home_course_storyboard.instantiateViewController(withIdentifier: "MainTBC") as? UITabBarController else { return }
            self.present(mainTBC, animated: true, completion: nil)
        }
    }
    
    @IBAction func KakaoLoginBtn(_ sender: Any) {
        let koSessionShared = KOSession.shared()
        if let session = koSessionShared {
            if session.isOpen() {
                session.close()
            }
            session.open(completionHandler: { (err) in
                if err == nil {
                    if session.isOpen() {
                        self.networkModel.kakaoLoginService(accessToken: session.accessToken)
                    }
                }
            })
        }
    }
}


