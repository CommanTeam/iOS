//
//  LectureInChapterVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class LectureInChapterVC: UIViewController, NetworkCallback {
    let userDefaults = UserDefaults.standard
    
    var chapterID: Int = 0
    var tableCount: Int = 2
    
    var token: String = ""
    var titleString: String = ""
    
    var registerCheck: Bool = false
    
    var chapterInfo: ChapterInfoVO!
    var baseNetworkModel: ChapterNetworkModel!
    var lectureListInChapter: [LectureListInChapterVO] = [LectureListInChapterVO]()
    
    @IBOutlet weak var lectureInChapterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.titleString
        self.baseNetworkModel = ChapterNetworkModel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.tableCount = 2
        self.token = userDefaults.string(forKey: "token")!
        
        baseNetworkModel.getChapterInfo(token: token, chapterID: self.chapterID)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "5-1" {
            guard let chapterInfoResult = resultData as? ChapterInfoResult else {
                return
            }
            self.chapterInfo = chapterInfoResult.data
            
            
            baseNetworkModel.getLectureListInChapter(token: self.token, chapterID: self.chapterID)
        } else if code == "6-1" {
            guard let lectureListInChapterResult = resultData as? LectureListInChapterResult else {
                return
            }
            self.lectureListInChapter = lectureListInChapterResult.result
            
            tableCount = tableCount + self.lectureListInChapter.count
            lectureInChapterTableView.delegate = self
            lectureInChapterTableView.dataSource = self
            lectureInChapterTableView.reloadData()
        }
    }
    func formatTime(millis: Int) -> String {
        let seconds = millis / 1000
        let minutes = seconds / 60
        let hours = minutes / 60
        var minStr: String = ""
        var secStr: String = ""
        
        if (minutes % 60) > 9 {
            minStr = "\(minutes % 60)"
        } else {
            minStr = "0\(minutes % 60)"
        }
        
        if (seconds % 60) > 9 {
            secStr = "\(seconds % 60)"
        } else {
            secStr = "0\(seconds % 60)"
        }
        
        if hours != 0 {
            return "\(hours) : \(minStr) : \(secStr)"
        } else {
            return "\(minStr) : \(secStr)"
        }
    }
}

extension LectureInChapterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 2 {
            
            switch self.lectureListInChapter[indexPath.row - 2].lectureType {
            case 0:
                let lecture_storyboard = UIStoryboard(name: "Lecture", bundle: nil)
                guard let quizMainVC = lecture_storyboard.instantiateViewController(withIdentifier: "QuizMainVC") as? QuizMainVC else { return }
                quizMainVC.lectureID = lectureListInChapter[indexPath.row - 2].lectureID
                self.navigationController?.pushViewController(quizMainVC, animated: true)
                break
            case 1:
                let lecture_storyboard = UIStoryboard(name: "Lecture", bundle: nil)
                guard let cardNewsVC = lecture_storyboard.instantiateViewController(withIdentifier: "CardNewsMainVC") as? CardNewsMainVC else { return }
                
                self.navigationController?.pushViewController(cardNewsVC, animated: true)
                break
            case 2:
                let lecture_storyboard = UIStoryboard(name: "Lecture", bundle: nil)
                guard let videoVC = lecture_storyboard.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC else { return }
                
                self.navigationController?.pushViewController(videoVC, animated: true)
                break
            default:
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterSummaryCell", for: indexPath) as! ChapterSummaryCell
            if self.chapterInfo.priority < 10 {
                cell.chapterTitleLabel.text = "[ 0\(self.chapterInfo.priority)장 ] \(self.chapterInfo.title)"
            } else {
                cell.chapterTitleLabel.text = "[ \(self.chapterInfo.priority)장 ] \(self.chapterInfo.title)"
            }
            cell.chapterSummaryLabel.text = self.chapterInfo.info
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterLabelCell", for: indexPath) as! ChapterLabelCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LectureListInChepterCell", for: indexPath) as! LectureListInChepterCell
            let lecType = self.lectureListInChapter[indexPath.row - 2].lectureType
            let flag = self.lectureListInChapter[indexPath.row - 2].watchedFlag
            var iconImg: UIImage!
            (lecType == 0) ? ((flag == 0) ? (iconImg = cell.quizIcon) : (iconImg = cell.completedQuizIcon)) : (lecType == 1) ? ((flag == 0) ? (iconImg = cell.picIcon) : (iconImg = cell.completedPicIcon)) : (lecType == 2) ? ((flag == 0) ? (iconImg = cell.videoIcon) : (iconImg = cell.completedVideoIcon)) : (iconImg = nil)
            
            cell.lectureIconImage.image = iconImg
            if (indexPath.row - 1) < 10 {
                cell.lectureTitleLabel.text = "0\((indexPath.row - 1)) \(self.lectureListInChapter[indexPath.row - 2].lectureTitle)"
            } else {
                cell.lectureTitleLabel.text = "\((indexPath.row - 1)) \(self.lectureListInChapter[indexPath.row - 2].lectureTitle)"
            }
            switch lecType {
            case 0:
                cell.lectureCountLabel.text = "\(self.lectureListInChapter[indexPath.row - 2].lectureCnt) 문제"
                break
            case 1:
                cell.lectureCountLabel.text = "\(self.lectureListInChapter[indexPath.row - 2].lectureCnt) 페이지"
                break
            case 2:
                cell.lectureCountLabel.text = "\(self.formatTime(millis: self.lectureListInChapter[indexPath.row - 2].playTime))"
                break
            default:
                break
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}


