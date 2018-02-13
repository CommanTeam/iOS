//
//  ChapterVO.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 10..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

struct ChapterInfoResult: Codable {
    let data: ChapterInfoVO
}

struct ChapterInfoVO: Codable {
    let id: Int
    let course_id: Int
    let info: String
    let title: String
    let priority: Int
}

struct LectureListInChapterResult: Codable {
    let result: [LectureListInChapterVO]
}

struct LectureListInChapterVO: Codable {
    let lectureID: Int
    let lecturePriority: Int
    let lectureTitle: String
    let lectureType: Int
    let chapterID: Int
    let playTime: Int
    let watchedFlag: Int
    let lectureCnt: Int
}
