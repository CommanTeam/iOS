//
//  LectureVO.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 11..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

struct LectureInfoResult: Codable {
    let result: LectureInfoVO
}

struct LectureInfoVO: Codable {
    let id: Int
    let chapter_id: Int
    let title: String
    let lecture_type: Int
    let file_path: String
    let priority: Int
    let info: String
    let pass_value: String
    let video_id: String
    let playTime: Int
}

struct QuizInfoResult: Codable {
    let result: [QuizInfoVO]
}

struct QuizInfoVO: Codable {
    let quizID: Int
    let quizTitle: String
    let quizPriority: Int
    let quizImage: String
    let explanation: String
    let questionArr: [QuestionVO]
}

struct QuestionVO: Codable {
    let questionID: Int
    let questionContent: String
    let answerFlag: Int
}

struct VideoInfoResult: Codable {
    let result: VideoInfo
}

struct VideoInfo: Codable {
    let lecture_id: Int
    let title: String
    let info: String
    let file_path: String
    let video_id: String
    let priority: Int
}
