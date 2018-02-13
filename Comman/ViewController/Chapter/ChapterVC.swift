//
//  ChapterVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 9..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit
import YouTubePlayer

class ChapterVC: UIViewController, UINavigationControllerDelegate, NetworkCallback {
    let userDefaults = UserDefaults.standard
    
    var courseID: Int = 0
    var lectureID: Int = 0
    var tableCount: Int = 1
    
    var registerCheck: Bool = false
    var purchaseCheck: Bool = false
    
    var token: String = ""
    var videoID: String = ""
    var titleString: String = ""
    var previewLectureTitle: String = ""
    
    var courseInfo: CourseInfoVO!
    var courseList: [CourseListVO]!
    var lectureRecent: LectureRecentWatchVO!
    var baseNetworkModel: ChapterNetworkModel!
    
    var resizingQuizThumbnail: UIImage!
    var resizingCardNewsThumbnail: UIImage!
    
    @IBOutlet weak var chapterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.titleString
        
        chapterTableView.delegate = self
        chapterTableView.dataSource = self
        let thumbnailQuiz = UIImage.init(named: "Quiz_Thumbnail")
        let thumbnailCardNews = UIImage.init(named: "CardNews_Thumbnail")
        self.resizingQuizThumbnail = thumbnailQuiz?.resizeImageWith(newSize: CGSize.init(width: 345.0, height: 113.0))
        self.resizingCardNewsThumbnail = thumbnailCardNews?.resizeImageWith(newSize: CGSize.init(width: 345.0, height: 113.0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableCount = 1
        baseNetworkModel = ChapterNetworkModel(self)
        self.token = userDefaults.string(forKey: "token")!
        baseNetworkModel.getCourseRegisterCheck(token: self.token, courseID: self.courseID)
    }
    
    @IBAction func navigationBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func chapterMoreExplain(_ sender: UIGestureRecognizer) {
        guard let cpvc = storyboard?.instantiateViewController(withIdentifier: "ChapterPopupVC") as? ChapterPopupVC else{
            return
        }
        cpvc.courseInfo = self.courseInfo
        cpvc.courseList = self.courseList
        self.present(cpvc, animated: true, completion: nil)
    }
    
    @objc func chpaterRegisterPopup(_ sender: UIButton) {
        guard let crpc = storyboard?.instantiateViewController(withIdentifier: "ChapterRegisterPopupVC") as? ChapterRegisterPopupVC else{
            return
        }
        crpc.courseID = self.courseID
        self.present(crpc, animated: true, completion: nil)
    }
    
    @objc func chapterBuyPopup(_ sender: UIButton) {
        guard let cppc = storyboard?.instantiateViewController(withIdentifier: "ChapterPaymentPopupVC") as? ChapterPaymentPopupVC else{
            return
        }
        self.present(cppc, animated: true, completion: nil)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "1-1" {
            guard let registerResult = resultData as? Int else {
                return
            }
            registerResult == 1 ? (self.registerCheck = true) : (self.registerCheck = false)
            if self.registerCheck == false {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            } else {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
            baseNetworkModel.getPurchaseCheck(token: self.token, courseID: self.courseID)
            
        } else if code == "1-3" {
            guard let registerResult = resultData as? Int else {
                return
            }
            registerResult == 1 ? (self.purchaseCheck = true) : (self.purchaseCheck = false)
            baseNetworkModel.getCourseInfo(token: self.token, courseID: self.courseID)
        } else if code == "2-1" {
            guard let courseInfoResult = resultData as? CourseInfoResult else {
                return
            }
            self.courseInfo = courseInfoResult.result
            if self.registerCheck {
                if userDefaults.object(forKey: "lectureID") != nil {
                    self.lectureID = userDefaults.integer(forKey: "lectureID")
                    baseNetworkModel.getLectureRecentWatch(token: self.token, lectureID: self.lectureID)
                } else {
                    baseNetworkModel.getChapterListInCourse(token: token, courseID: self.courseID)
                }
            } else {
                self.tableCount = self.tableCount + 1
                baseNetworkModel.getPreviewVideo(token: self.token, courseID: self.courseID)
            }
        } else if code == "3-1" {
            if userDefaults.object(forKey: "lectureID") != nil {
                self.lectureID = userDefaults.integer(forKey: "lectureID")
                self.tableCount = self.tableCount + 1
                baseNetworkModel.getChapterListInCourse(token: token, courseID: self.courseID)
            }
            guard let lectureRecent = resultData as? LectureResult else { return }
            self.lectureRecent = lectureRecent.result
        } else if code == "3-2" {
            baseNetworkModel.getChapterListInCourse(token: token, courseID: self.courseID)
        } else if code == "3-3" {
            guard let previewData = resultData as? [String] else { return }
            print(previewData)
            self.videoID = previewData[0]
            self.previewLectureTitle = "\(previewData[2]) \(previewData[1])"
            self.tableCount = self.tableCount + 1
            baseNetworkModel.getChapterListInCourse(token: token, courseID: self.courseID)
        } else if code == "4-1" {
            guard let courseListResult = resultData as? CourseListResult else {
                return
            }
            self.courseList = courseListResult.result
            self.tableCount = self.tableCount + 1 + self.courseList.count
            if !registerCheck {
                self.navigationController?.hidesBarsOnSwipe = false
            }
            self.chapterTableView.reloadData()
        }
    }
}

extension ChapterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.lectureID != 0 {
            if indexPath.row >= 3 {
                if courseList[indexPath.row - 3].open {
                    guard let lectureInChapterVC = storyboard?.instantiateViewController(withIdentifier: "LectureInChapterVC") as? LectureInChapterVC else {
                        return
                    }
                    lectureInChapterVC.chapterID = self.courseList[indexPath.row - 3].chapterID
                    if (self.courseList[indexPath.row - 3].priority) > 10 {
                        lectureInChapterVC.titleString = "[ \(self.courseList[indexPath.row - 3].priority)장 ] \(self.courseList[indexPath.row - 3].title)"
                    } else {
                        lectureInChapterVC.titleString = "[ 0\(self.courseList[indexPath.row - 3].priority)장 ] \(self.courseList[indexPath.row - 3].title)"
                    }
                    self.navigationController?.pushViewController(lectureInChapterVC, animated: true)
                } else {
                    // 단원이 잠겨 있는 경우
                }
            }
        } else {
            if self.registerCheck {
                if indexPath.row >= 2 {
                    if courseList[indexPath.row - 2].open {
                        guard let lectureInChapterVC = storyboard?.instantiateViewController(withIdentifier: "LectureInChapterVC") as? LectureInChapterVC else{
                            return
                        }
                        lectureInChapterVC.chapterID = self.courseList[indexPath.row - 2].chapterID
                        if (self.courseList[indexPath.row - 2].priority) > 10 {
                            lectureInChapterVC.titleString = "[ \(self.courseList[indexPath.row - 2].priority)장 ] \(self.courseList[indexPath.row - 2].title)"
                        } else {
                            lectureInChapterVC.titleString = "[ 0\(self.courseList[indexPath.row - 2].priority)장 ] \(self.courseList[indexPath.row - 2].title)"
                        }
                        self.navigationController?.pushViewController(lectureInChapterVC, animated: true)
                    } else {
                        // 단원이 잠겨 있는 경우
                    }
                }
            } else {
                if indexPath.row >= 4 {
                    if courseList[indexPath.row - 2].open {
                        guard let lectureInChapterVC = storyboard?.instantiateViewController(withIdentifier: "LectureInChapterVC") as? LectureInChapterVC else{
                            return
                        }
                        lectureInChapterVC.chapterID = self.courseList[indexPath.row - 4].chapterID
                        if (self.courseList[indexPath.row - 4].priority) > 10 {
                            lectureInChapterVC.titleString = "[ \(self.courseList[indexPath.row - 4].priority)장 ] \(self.courseList[indexPath.row - 4].title)"
                        } else {
                            lectureInChapterVC.titleString = "[ 0\(self.courseList[indexPath.row - 4].priority)장 ] \(self.courseList[indexPath.row - 4].title)"
                        }
                        self.navigationController?.pushViewController(lectureInChapterVC, animated: true)
                    } else {
                        // 단원이 잠겨 있는 경우
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterExpCell", for: indexPath) as! ChapterExpCell
            guard let tableChap = self.courseInfo else { return UITableViewCell() }
            cell.instructorProfile.imageFromUrl(tableChap.supplier_thumbnail, defaultImgPath: "chap_default_profile_icon")
            cell.courseNameLabel.text = tableChap.title
            cell.instructorLabel.text = tableChap.name
            cell.courseExpLabel.text = tableChap.info
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.chapterMoreExplain(_:)))
            cell.moreLabel.addGestureRecognizer(gesture)
            cell.moreBackView.addGestureRecognizer(gesture)
            cell.expInnerView.addInnerShadow(onSide: .bottom, shadowColor: .black,  shadowSize: 1.5, shadowOpacity: 0.15)
            cell.selectionStyle = .none
            return cell
        } else {
            if self.registerCheck == false {
                if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterPreviewCell", for: indexPath) as! ChapterPreviewCell
                    cell.previewPlayer.playerVars = ["playsinline" : 1 as AnyObject,
                                                        "showinfo" : 2 as AnyObject,
                                                        "controls" : 0 as AnyObject]
                    
                    cell.previewPlayer.loadVideoID(self.videoID)
                    cell.previewLectureTitle.text = self.previewLectureTitle
                    let delayInSeconds = 3.5
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                        let duration = cell.previewPlayer.getDuration()!
                        let maxTime = Int(duration)
                        let minutes: Int = maxTime! / 60
                        let seconds: Int = maxTime! - (minutes * 60)
    
                        if minutes < 10 {
                            cell.allMinLabel.text = "0\(minutes)"
                        } else {
                            cell.allMinLabel.text = "\(minutes)"
                        }
                        if seconds < 10 {
                            cell.allSecLabel.text = "0\(seconds)"
                        } else {
                            cell.allSecLabel.text = "\(seconds)"
                        }
                        cell.previewProgressBar.value = 0.0
                        cell.previewProgressBar.maximumValue = Float(maxTime!)
                        cell.selectionStyle = .none
                    }
                    return cell
                    
                } else if indexPath.row == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterRegisterBtnCell", for: indexPath) as! ChapterRegisterBtnCell
                    cell.chapterRegisterBtn.addTarget(self, action: #selector(self.chpaterRegisterPopup(_:)), for: .touchUpInside)
                    cell.selectionStyle = .none
                    return cell
                } else if indexPath.row == 3 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterLabelCell", for: indexPath) as! ChapterLabelCell
                    cell.chapterBuyBtn.addTarget(self, action: #selector(chapterBuyPopup(_:)), for: .touchUpInside)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterListCell", for: indexPath) as! ChapterListCell
                    cell.chapNumLabel.text = "\(courseList[indexPath.row - 4].priority)장"
                    cell.chapNameLabel.text = courseList[indexPath.row - 4].title
                    cell.lecAllNumLabel.text = "\(courseList[indexPath.row - 4].lectureCnt)"
                    self.courseList[indexPath.row - 4].open ? (cell.opacityView.isHidden = true) : (cell.opacityView.isHidden = false)
                    cell.selectionStyle = .none
                    return cell
                }
            } else {
                if self.lectureID != 0 {
                    if indexPath.row == 1 {
                        if self.lectureRecent.lecture_type == 2 {
                            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterWithVideoCell", for: indexPath) as! ChapterWithVideoCell
                            if let videoID = self.lectureRecent.lecture_video_id {
                                let youtubeThumbnailPath = YouTubePlayerView.thumbnailURLString(videoID: videoID, quailty: .High)
                                cell.lecVideoImg.imageFromUrl(youtubeThumbnailPath, defaultImgPath: "")
                            } else {
                                cell.lecVideoImg.imageFromUrl("", defaultImgPath: "")
                            }
                            cell.chapIconImg.image = cell.videoIcon
                            cell.mainLectureTitle.text = "\(self.lectureRecent.course_title) > \(self.lectureRecent.chapter_priority)"
                            cell.subLectureTitle.text = "\(self.lectureRecent.lecture_priority) > \(self.lectureRecent.lecture_title)"
                            cell.opacityView.customRadius(onSide: .top)
                            cell.infoBackView.customRadius(onSide: .bottom)
                            cell.selectionStyle = .none
                            return cell
                        } else {
                            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterWithoutVideoCell", for: indexPath) as! ChapterWithoutVideoCell
                            self.lectureRecent.lecture_type == 0 ? (cell.chapIconImg.image = cell.quizIcon) : (cell.chapIconImg.image = cell.pictureIcon)
                            self.lectureRecent.lecture_type == 0 ? (cell.lecVideoImg.image = self.resizingQuizThumbnail) : (cell.lecVideoImg.image = self.resizingCardNewsThumbnail)
                            
                            cell.mainLectureTitle.text = "\(self.lectureRecent.course_title) > \(self.lectureRecent.chapter_priority)"
                            cell.subLectureTitle.text = "\(self.lectureRecent.lecture_priority) > \(self.lectureRecent.lecture_title)"
                            cell.opacityView.customRadius(onSide: .top)
                            cell.lecVideoImg.customRadius(onSide: .top)
                            cell.infoBackView.customRadius(onSide: .bottom)
                            cell.selectionStyle = .none
                            return cell
                        }
                    } else if indexPath.row == 2 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterLabelCell", for: indexPath) as! ChapterLabelCell
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterListCell", for: indexPath) as! ChapterListCell
                        cell.chapNumLabel.text = "\(courseList[indexPath.row - 3].priority)장"
                        cell.chapNameLabel.text = courseList[indexPath.row - 3].title
                        cell.lecAllNumLabel.text = "\(courseList[indexPath.row - 3].lectureCnt)"
                        self.courseList[indexPath.row - 3].open ? (cell.opacityView.isHidden = true) : (cell.opacityView.isHidden = false)
                        cell.selectionStyle = .none
                        return cell
                    }
                } else {
                    if indexPath.row == 1 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterLabelCell", for: indexPath) as! ChapterLabelCell
                        if self.purchaseCheck {
                            cell.chapterBuyBtn.isHidden = true
                        } else {
                            cell.chapterBuyBtn.addTarget(self, action: #selector(chapterBuyPopup(_:)), for: .touchUpInside)
                        }
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterListCell", for: indexPath) as! ChapterListCell
                        cell.chapNumLabel.text = "\(courseList[indexPath.row - 2].priority)장"
                        cell.chapNameLabel.text = courseList[indexPath.row - 2].title
                        cell.lecAllNumLabel.text = "\(courseList[indexPath.row - 2].lectureCnt)"
                        self.courseList[indexPath.row - 2].open ? (cell.opacityView.isHidden = true) : (cell.opacityView.isHidden = false)
                        cell.selectionStyle = .none
                        return cell
                    }
                }
            }
        }
    }
}

