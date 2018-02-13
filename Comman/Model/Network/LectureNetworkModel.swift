//
//  LectureNetworkModel.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 11..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LectureNetworkModel: NetworkModel {
    func setUserLectureHistory(token: String, lectureID: Int) {
        let URL = "\(baseURL)/users/lectureHistory"
        let params = ["lectureID" : lectureID]
        Alamofire.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    guard let result = data["message"].string else {
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
    
    func getLectureQuiz(token: String, lectureID: Int) {
        let URL = "\(baseURL)/content/lecturequiz/\(lectureID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let quizInfoResult = try decoder.decode(QuizInfoResult.self, from: value)
                        self.view.networkResult(resultData: quizInfoResult, code: "2-1")
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
    
    func getVideoID(token: String, lectureID: Int) {
        let URL = "\(baseURL)/content/lecturevideo/\(lectureID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let quizInfoResult = try decoder.decode(QuizInfoResult.self, from: value)
                        self.view.networkResult(resultData: quizInfoResult, code: "2-1")
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
}
