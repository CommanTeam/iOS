//
//  SearchNetworkModel.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 11..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Kingfisher

class SearchNetworkModel: NetworkModel {
    
    func getCateCourseList(token: String) {
        let URL = "\(baseURL)/content/categories/course"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let cateCourseList = try decoder.decode(CateCourseList.self, from: value)
                        self.view.networkResult(resultData: cateCourseList.result, code: "getCateCourseList")
                    } catch let err as NSError {
                        self.view.networkResult(resultData: "nondata", code: "fail_getCateCourseList")
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
    
    func getSearchResultList(token: String, search: String) {
        let body : [String : String] = ["search" : search]
        
        let URL = "\(baseURL)/search/courses"
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let searchResultList = try decoder.decode(SearchResultList.self, from: value)
                        self.view.networkResult(resultData: searchResultList.result, code: "getSearchResultList")
                    } catch let err as NSError {
                        self.view.networkResult(resultData: "nondata", code: "fail_getSearchResultList")
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
    
    func getSearchCategoryResult(token: String, categoryID: Int) {
        let URL = "\(baseURL)/search/courses/categories/\(categoryID)"
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["authorization" : token]).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let searchResultList = try decoder.decode(SearchResultList.self, from: value)
                        self.view.networkResult(resultData: searchResultList.result, code: "getSearchResultList")
                    } catch let err as NSError {
                        self.view.networkResult(resultData: "nondata", code: "fail_getSearchResultList")
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
