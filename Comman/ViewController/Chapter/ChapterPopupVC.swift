//
//  ChapterPopupVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 5..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class ChapterPopupVC: UIViewController {
    @IBOutlet weak var popUpInnerView: UIView!
    @IBOutlet weak var popUpTableView: UITableView!
    
    var courseInfo: CourseInfoVO!
    var courseList: [CourseListVO]!
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpTableView.delegate = self
        popUpTableView.dataSource = self
        
        self.popUpInnerView.addInnerShadow(onSide: .bottom, shadowColor: .black, shadowSize: 10.0, shadowOpacity: 0.15)
    }
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func outerViewTapGesture(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ChapterPopupVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseList.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterPopupInfoCell", for: indexPath) as! ChapterPopupInfoCell
            cell.popUpProfileImg.imageFromUrl(courseInfo.supplier_thumbnail, defaultImgPath: "popup_default_profile_icon")
            cell.popUpCourseTitleLabel.text = courseInfo.title
            cell.popUpInstructorLabel.text = courseInfo.name
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterPopupLecInfoCell", for: indexPath) as! ChapterPopupLecInfoCell
            if self.courseList[indexPath.row - 1].priority < 10 {
                cell.lectureTitleLabel.text = "0\(self.courseList[indexPath.row - 1].priority) \(self.courseList[indexPath.row - 1].title)"
            } else {
                cell.lectureTitleLabel.text = "\(self.courseList[indexPath.row - 1].priority) \(self.courseList[indexPath.row - 1].title)"
            }
            cell.lectureInfoLabel.text = self.courseList[indexPath.row - 1].info
            cell.selectionStyle = .none
            return cell
        }
    }
}
