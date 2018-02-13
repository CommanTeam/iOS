//
//  SearchService.swift
//  Comman
//
//  Created by Kiyong Shin on 04/01/2018.
//  Copyright © 2018 havetherain. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SearchService {
    static let baseURL = ""
    
    static func getCourseList(onCourseList : @escaping (CourseList)->()) {
        let URL = "\(baseURL)/board/list"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do{
                        print("do")
                        let courseList = try decoder.decode(CourseList.self, from: value)
                        onCourseList(courseList)
                    } catch let err as NSError {
                        print(err.localizedDescription)
                    }
                }
                break
            case .failure(let err) :
                print("fail")
                print(err.localizedDescription)
                break
            }
        }
    }
}

