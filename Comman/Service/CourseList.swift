//
//  CourseListInfo.swift
//  Comman
//
//  Created by Kiyong Shin on 04/01/2018.
//  Copyright © 2018 havetherain. All rights reserved.
//

import Foundation

struct CourseList : Codable {
    let result : [DetailCourseList]
}

struct DetailCourseList : Codable {
    let categoryID : Int
    let categoryName : String
    let title : String
    
}
