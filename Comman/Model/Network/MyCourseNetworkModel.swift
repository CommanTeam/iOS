//
//  MyCourseModel.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 8..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Kingfisher

class MyCourseNetworkModel: NetworkModel {
    func getWelcomeMsg(token: String) {
        let URL = "\(baseURL)/users/main/greeting"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:  ["authorization" : token]).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    guard let result = (data["result"])["ment"].string else {
                        return
                    }
                    self.view.networkResult(resultData: result, code: "1-1")
                }
                break
            case .failure(let err) :
                self.view.networkFailed()
                print(err.localizedDescription)
                break
            }
        }
    }
    
    func getLectureRecentWatch(token: String, lectureID: Int) {
        let URL = "\(baseURL)/users/lectureRecentWatch/\(lectureID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let lecRecent = try decoder.decode(LectureResult.self, from: value)
                        self.view.networkResult(resultData: lecRecent, code: "2-1")
                    } catch let err as NSError {
                        self.view.networkResult(resultData: "nondata", code: "2-2")
                        print(err.localizedDescription)
                    }
                }
                break
            case .failure(let err) :
                self.view.networkFailed()
                print(err.localizedDescription)
                break
            }
        }
    }
    
    func getProgressLectureInfo(token: String) {
        let URL = "\(baseURL)/users/main/progressCourse"
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let progressLectureResult = try decoder.decode(ProgressLectureResult.self, from: value)
                        print(progressLectureResult)
                        self.view.networkResult(resultData: progressLectureResult, code: "3-1")
                    } catch let err as NSError {
                        self.view.networkResult(resultData: "nondata", code: "3-2")
                        print(err.localizedDescription)
                    }
                }
                break
            case .failure(let err) :
                self.view.networkFailed()
                print(err.localizedDescription)
                break
            }
        }
    }
    
    func registerCourse(token: String, courseID: Int) {
        let URL = "\(baseURL)/users/register"
        let params = ["courseID" : courseID]
        Alamofire.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    guard let result = data["message"].string else {
                        return
                    }
                    print(result)
                    self.view.networkResult(resultData: result, code: "registerCourse")
                }
                break
            case .failure(let err) :
                self.view.networkFailed()
                print(err.localizedDescription)
                break
            }
        }
    }
}

