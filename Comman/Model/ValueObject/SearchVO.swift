//
//  SearchVO.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 11..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

struct CateCourseList: Codable {
    let result: [CateListVO]
}

struct CateListVO: Codable {
    let categoryID : Int
    let categoryName : String
    let categoryImg : String
    let title : [String]
}

struct SearchResultList: Codable {
    let result: [SearchResultListVO]
}

struct SearchResultListVO: Codable {
    let id : Int
    let title : String
    let info : String
    let image_path : String
    let hit : Int? = 0
}
