//
//  ChapterNetworkModel.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 10..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChapterNetworkModel: NetworkModel {
    func getCourseRegisterCheck(token: String, courseID: Int) {
        let URL = "\(baseURL)/users/register/\(courseID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    guard let result = data["result"].int else {
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
    
    func getPurchaseCheck(token: String, courseID: Int) {
        let URL = "\(baseURL)/users/purchase/\(courseID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    guard let result = data["result"].int else {
                        return
                    }
                    self.view.networkResult(resultData: result, code: "1-3")
                }
                break
            case .failure(let err) :
                self.view.networkFailed()
                print(err.localizedDescription)
                break
            }
        }
    }
    
    func getCourseInfo(token: String, courseID: Int) {
        let URL = "\(baseURL)/content/courses?courseID=\(courseID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let courseInfoResult = try decoder.decode(CourseInfoResult.self, from: value)
                        self.view.networkResult(resultData: courseInfoResult, code: "2-1")
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
    
    func getLectureRecentWatch(token: String, lectureID: Int) {
        let URL = "\(baseURL)/users/lectureRecentWatch/\(lectureID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let lecRecent = try decoder.decode(LectureResult.self, from: value)
                        self.view.networkResult(resultData: lecRecent, code: "3-1")
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
    
    func getPreviewVideo(token: String, courseID: Int) {
        let URL = "\(baseURL)/content/coursepage/previewvideo/\(courseID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    let resultData = JSON(data["result"].object)
                    guard let video_id = resultData["video_id"].string,
                          let lecture_title = resultData["lecture_title"].string,
                          let lecture_priority = resultData["lecture_priority"].int else {
                            return
                    }
                    if lecture_priority > 9 {
                        let result = [video_id, lecture_title, "\(lecture_priority)"]
                        self.view.networkResult(resultData: result, code: "3-3")
                    } else {
                        let result = [video_id, lecture_title, "0\(lecture_priority)"]
                        self.view.networkResult(resultData: result, code: "3-3")
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
    
    func getChapterListInCourse(token: String, courseID: Int) {
        let URL = "\(baseURL)/content/courses/\(courseID)/chapters"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let courseListResult = try decoder.decode(CourseListResult.self, from: value)
                        self.view.networkResult(resultData: courseListResult, code: "4-1")
                    } catch let err as NSError {
                        self.view.networkResult(resultData: "nondata", code: "4-2")
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
    
    func getChapterInfo(token: String, chapterID: Int) {
        let URL = "\(baseURL)/content/chapters?chapterID=\(chapterID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let chapterInfoResult = try decoder.decode(ChapterInfoResult.self, from: value)
                        self.view.networkResult(resultData: chapterInfoResult, code: "5-1")
                    } catch let err as NSError {
                        self.view.networkResult(resultData: "nondata", code: "5-2")
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
    
    func getLectureListInChapter(token: String, chapterID: Int) {
        let URL = "\(baseURL)/content/lecturepage/lectureList?chapterID=\(chapterID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let lectureListInChapterResult = try decoder.decode(LectureListInChapterResult.self, from: value)
                        self.view.networkResult(resultData: lectureListInChapterResult, code: "6-1")
                    } catch let err as NSError {
                        self.view.networkResult(resultData: "nondata", code: "6-2")
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
