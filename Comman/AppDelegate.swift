//
//  AppDelegate.swift
//  Comman
//
//  Created by 김지우 on 2017. 12. 31..
//  Copyright © 2017년 havetherain. All rights reserved.
//

import UIKit
import YoutubeKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 20)!, NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationBarAppearace.barTintColor = UIColor.init(hexString: "#4777D9")
        navigationBarAppearace.isTranslucent = false
        
        let tabBarApperance = UITabBarItem.appearance()
        tabBarApperance.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 15)!], for: .normal)
        tabBarApperance.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 15)!], for: .selected)
        YoutubeKit.shared.setAPIKey("AIzaSyBkwekDMku41r_fHPYG-WDJ_MiBvZzXDlI")
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        //kakao
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return true
    }
    
    func application(application: UIApplication, handleOpenURL url: URL) -> Bool {
        //kakao
        if KOSession.isKakaoAccountLoginCallback(url as URL!) {
            return KOSession.handleOpen(url as URL!)
        }
        return false
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}

