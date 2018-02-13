//
//  LoginNetworkModel.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 11..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Kingfisher

class LoginNetworkModel: NetworkModel {
    func kakaoLoginService(accessToken: String) {
        let URL = "\(baseURL)/users/insert_user_info"
        let params = ["accessToken": accessToken]
        var responseList: [String] = []
        
        Alamofire.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    let result = JSON(data["result"].object)
                    guard let token = result["token"].string else {
                        return
                    }
                    let userData = JSON(result["user"].object)
                    guard let nickname = userData["nickname"].string, let thumbnail_image = userData["thumbnail_image"].string else {
                        return
                    }
                    print("token : " + token)
                    
                    responseList.append(token)
                    responseList.append(nickname)
                    responseList.append(thumbnail_image)
                    self.view.networkResult(resultData: responseList, code: "1-1")
                }
                break
            case .failure(let err) :
                print(err.localizedDescription)
                break
            }
        }
    }
}
