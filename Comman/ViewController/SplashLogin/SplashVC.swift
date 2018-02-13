//
//  SplashVC.swift
//  Comman
//
//  Created by 김지우 on 2017. 12. 31..
//  Copyright © 2017년 havetherain. All rights reserved.
//

import Foundation
import UIKit

class SplashVC : UIViewController {
    @IBOutlet weak var flash: UIImageView!

    let delayInSeconds = 2.3
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let appDomain = Bundle.main.bundleIdentifier
//        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        self.flash.loadGif(name: "flash")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            if self.userDefaults.string(forKey: "token") != nil {
                let home_course_storyboard = UIStoryboard(name: "Home", bundle: nil)
                guard let mainTBC = home_course_storyboard.instantiateViewController(withIdentifier: "MainTBC") as? UITabBarController else { return }
                self.present(mainTBC, animated: true, completion: nil)
            }
            else {
                guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") else {return}
                self.present(loginVC, animated: true, completion: nil)
            }
        } //DispatchQueue.main
    } //viewDidLoad
}
