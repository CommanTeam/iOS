//
//  CourseVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit
import YouTubePlayer

class CourseVC: UIViewController, NetworkCallback {
    let userDefaults = UserDefaults.standard
    
    var lectureID: Int = 0
    var tableCount: Int = 1
    
    var token: String = ""
    var youtubeID: String = ""
    var username: String = ""
    var welcomeMsg: String = ""
    var profileImagePath: String = ""
    
    var resizingQuizThumbnail: UIImage!
    var resizingCardNewsThumbnail: UIImage!
    
    var baseModel: MyCourseNetworkModel!
    var lectureRecent: LectureRecentWatchVO!
    var progressLecture: [ProgressLectureVO]!
    
    @IBOutlet weak var courseMainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbnailQuiz = UIImage.init(named: "Quiz_Thumbnail")
        let thumbnailCardNews = UIImage.init(named: "CardNews_Thumbnail")
        self.resizingQuizThumbnail = thumbnailQuiz?.resizeImageWith(newSize: CGSize.init(width: 345.0, height: 113.0))
        self.resizingCardNewsThumbnail = thumbnailCardNews?.resizeImageWith(newSize: CGSize.init(width: 345.0, height: 113.0))
        
        self.baseModel = MyCourseNetworkModel(self)
        
        self.setTabBarItemPostion()
        self.addNavBarImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableCount = 1
        self.courseMainTableView.delegate = self
        self.courseMainTableView.dataSource = self
        
        guard let token = userDefaults.string(forKey: "token"), let username = userDefaults.string(forKey: "nickname"), let profileImagePath = userDefaults.string(forKey: "thumbnailPath") else {
            return
        }
        self.token = token
        self.username = username
        self.profileImagePath = profileImagePath
        
        self.baseModel.getWelcomeMsg(token: token)
    }
    
    func addNavBarImage() {
        let navController = navigationController!
        
        let image = UIImage.init(named: "navigation_logo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth/2, height: bannerHeight/2)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
        self.navigationController?.navigationItem.titleView = imageView
    }
    
    func setTabBarItemPostion() {
        guard let tabBar = self.tabBarController?.tabBar else {
            return
        }
        self.setTabBarBg(tabBar)
    }
    
    func setTabBarBg(_ mainTabBar: UITabBar) {
        mainTabBar.shadowImage = UIImage()
        let topBorder = CALayer()
        let borderHeight: CGFloat = 1.0
        topBorder.borderWidth = borderHeight
        topBorder.borderColor = UIColor.init(hexString: "#E9E9E9").cgColor
        topBorder.frame = CGRect(x: 0, y: 0, width: mainTabBar.frame.width, height: borderHeight)
        mainTabBar.layer.addSublayer(topBorder)
        
        let tabBarBg = UIImage.init(named: "tab_bar_bg")
        mainTabBar.backgroundImage = (tabBarBg?.resizeImageWith(newSize: CGSize.init(width: 375.0, height: 49.0)))!
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "1-1" {
            guard let welcomeMsg = resultData as? String else {
                return
            }
            self.welcomeMsg = welcomeMsg
            if userDefaults.object(forKey: "lectureID") != nil {
                self.lectureID = userDefaults.integer(forKey: "lectureID")
                self.baseModel.getLectureRecentWatch(token: self.token, lectureID: lectureID)
            } else {
                self.baseModel.getProgressLectureInfo(token: self.token)
            }
        } else if code == "2-1" {
            guard let lectureRecent = resultData as? LectureResult else {
                return
            }
            print("2-1")
            self.lectureRecent = lectureRecent.result
            self.tableCount = self.tableCount + 1
            baseModel.getProgressLectureInfo(token: self.token)
        } else if code == "3-1" {
            guard let progressLecture = resultData as? ProgressLectureResult else {
                return
            }
            print("3-1")
            print(self.progressLecture)
            self.progressLecture = progressLecture.result
            self.tableCount = self.tableCount + 1 + self.progressLecture.count
            self.courseMainTableView.reloadData()
        } else if code == "3-2" {
            print("3-2")
            self.tableCount = self.tableCount + 1
            self.courseMainTableView.reloadData()
        }
    }
    
    @objc func moveSeachCourseTab(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
    }
}
extension CourseVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        } else {
            if lectureRecent != nil {
                if indexPath.row == 2 { return nil }
                else { return indexPath }
            } else {
                if indexPath.row == 1 { return nil }
                else { return indexPath }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.lectureID != 0 {
            if indexPath.row == 1 {
                if self.lectureRecent.lecture_type == 2 {
                    let lecture_storyboard = UIStoryboard(name: "Lecutre", bundle: nil)
                    guard let videoVC = lecture_storyboard.instantiateViewController(withIdentifier: "VideoVC") as? VideoVC else { return }
                    self.navigationController?.pushViewController(videoVC, animated: true)
                } /* 시청하던 강의가 있고 그게 영상인 경우 */ else {
                    let lecture_storyboard = UIStoryboard(name: "Lecutre", bundle: nil)
                    if self.lectureRecent.lecture_type == 0 {
                        guard let quizMainVC = lecture_storyboard.instantiateViewController(withIdentifier: "QuizMainVC") as? QuizMainVC else { return }
                        self.navigationController?.pushViewController(quizMainVC, animated: true)
                    } /* 시청하던 강의가 있고 그게 퀴즈인 경우 */ else {
                        guard let cardNewsVC = lecture_storyboard.instantiateViewController(withIdentifier: "CardNewsVC") as? CardNewsVC else { return }
                        self.navigationController?.pushViewController(cardNewsVC, animated: true)
                    } // 시청하던 강의가 있고 그게 카드뉴스인 경우
                }
            } else if indexPath.row >= 3 {
                let chapter_storyboard = UIStoryboard(name: "Chapter", bundle: nil)
                guard let chapterVC = chapter_storyboard.instantiateViewController(withIdentifier: "ChapterVC") as? ChapterVC else { return }
                chapterVC.courseID = self.progressLecture[indexPath.row - 3].courseID
                tableCount = 1
                self.navigationController?.pushViewController(chapterVC, animated: true)
            }
        } else {
            if indexPath.row >= 2 {
                let chapter_storyboard = UIStoryboard(name: "Chapter", bundle: nil)
                guard let chapterVC = chapter_storyboard.instantiateViewController(withIdentifier: "ChapterVC") as? ChapterVC else { return }
                chapterVC.courseID = self.progressLecture[indexPath.row - 2].courseID
                tableCount = 1
                self.navigationController?.pushViewController(chapterVC, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWelcomeCell", for: indexPath) as! HomeWelcomeCell
            cell.homeProfileImage.imageFromUrl(self.profileImagePath, defaultImgPath: "home_profile_icon")
            cell.welcomeMsgLabel.text = self.username + self.welcomeMsg
            cell.selectionStyle = .none
            return cell
        } else {
            if self.lectureID != 0 {
                if indexPath.row == 1 {
                    if self.lectureRecent.lecture_type == 2 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWithVideoCell", for: indexPath) as! HomeWithVideoCell
                        if let videoID = self.lectureRecent.lecture_video_id {
                            let youtubeThumbnailPath = YouTubePlayerView.thumbnailURLString(videoID: videoID, quailty: .High)
                            cell.youtubeThumbnailImg.imageFromUrl(youtubeThumbnailPath, defaultImgPath: "")
                        } else {
                            cell.youtubeThumbnailImg.imageFromUrl("", defaultImgPath: "")
                        }
                        cell.chapIconImg.image = cell.videoIcon
                        cell.mainLectureTitle.text = "\(self.lectureRecent.course_title) > \(self.lectureRecent.chapter_priority)"
                        cell.subLectureTitle.text = "\(self.lectureRecent.lecture_priority) > \(self.lectureRecent.lecture_title)"
                        cell.opacityView.customRadius(onSide: .top)
                        cell.infoBackView.customRadius(onSide: .bottom)
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWithoutVideoCell", for: indexPath) as! HomeWithoutVideoCell
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
                } else {
                    if progressLecture.count != 0 {
                        if indexPath.row == 2 {
                            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeLabelCell", for: indexPath) as! HomeLabelCell
                            cell.selectionStyle = .none
                            return cell
                        } else {
                            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCourseListCell", for: indexPath) as! HomeCourseListCell
                            cell.courseImageView.imageFromUrl(self.progressLecture[indexPath.row - 3].imagePath, defaultImgPath: "")
                            cell.courseTitleLabel.text = progressLecture[indexPath.row - 3].courseTitle
                            cell.countChapterLabel.text = "총 \(progressLecture[indexPath.row - 3].chapterCnt) 단원"
                            cell.progressRateLabel.text = "\(progressLecture[indexPath.row - 3].progressPercentage)"
                            let percent = (Float(progressLecture[indexPath.row - 3].progressPercentage) * 0.01)
                            cell.progressRateBar.progress = percent
                            cell.courseImageView.customRadius(onSide: .left)
                            cell.selectionStyle = .none
                            return cell
                        }
                    } else {
                        let cell = UITableViewCell()
                        cell.backgroundColor = UIColor.init(hexString: "#EEEEEE")
                        return cell
                    }
                }
            } else {
                if self.progressLecture.count == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeUnregisteredCell", for: indexPath) as! HomeUnregisteredCell
                    cell.courseSearchBtn.addTarget(self, action: #selector(moveSeachCourseTab(_:)), for: .touchUpInside)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    if indexPath.row == 1 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeLabelCell", for: indexPath) as! HomeLabelCell
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCourseListCell", for: indexPath) as! HomeCourseListCell
                        cell.courseImageView.imageFromUrl(self.progressLecture[indexPath.row - 2].imagePath, defaultImgPath: "")
                        cell.courseTitleLabel.text = progressLecture[indexPath.row - 2].courseTitle
                        cell.countChapterLabel.text = "총 \(progressLecture[indexPath.row - 2].chapterCnt) 단원"
                        cell.progressRateLabel.text = "\(progressLecture[indexPath.row - 2].progressPercentage)"
                        let percent = (Float(progressLecture[indexPath.row - 2].progressPercentage) * 0.01)
                        cell.progressRateBar.progress = percent
                        cell.courseImageView.customRadius(onSide: .left)
                        cell.selectionStyle = .none
                        return cell
                    }
                }
            }
        }
    }
}
