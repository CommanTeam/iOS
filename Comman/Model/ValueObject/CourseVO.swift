//
//  CourseVO.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 8..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

struct LectureResult: Codable {
    let result: LectureRecentWatchVO
}

struct LectureRecentWatchVO: Codable {
    let course_ID: Int
    let course_title: String
    let chapter_priority: Int
    let chapter_ID: Int
    let lecture_title: String
    let lecture_priority: Int
    let lecture_type: Int
    let lecture_video_id: String?
    let cnt_lecture_quiz: Int
    let cnt_lecture_picture: Int
}

struct ProgressLectureResult: Codable {
    let result: [ProgressLectureVO]
}

struct ProgressLectureVO: Codable {
    let courseID: Int
    let imagePath: String
    let courseTitle: String
    let chapterCnt: Int
    let progressPercentage: Int
}

struct CourseInfoResult: Codable {
    let result: CourseInfoVO
}

struct CourseInfoVO: Codable {
    let id: Int
    let supplier_id: Int
    let opened_chapter: Int
    let image_path: String
    let name: String
    let supplier_thumbnail: String
    let title: String
    let info: String
    let price: Int
    let category_id: Int
}

struct CourseListResult: Codable {
    let result: [CourseListVO]
}

struct CourseListVO: Codable {
    let chapterID: Int
    let lectureCnt: Int
    let info: String
    let title: String
    let priority: Int
    let open: Bool
}
