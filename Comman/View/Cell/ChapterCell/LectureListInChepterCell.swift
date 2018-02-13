//
//  LectureListInChepterCell.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class LectureListInChepterCell: UITableViewCell {
    @IBOutlet weak var lectureIconImage: UIImageView!
    @IBOutlet weak var lectureCountLabel: UILabel!
    @IBOutlet weak var lectureTitleLabel: UILabel!
    
    let picIcon = UIImage.init(named: "chap_picture_icon")
    let completedPicIcon = UIImage.init(named: "chap_completed_picture_icon")
    
    let quizIcon = UIImage.init(named: "chap_quiz_icon")
    let completedQuizIcon = UIImage.init(named: "chap_completed_quiz_icon")
    
    let videoIcon = UIImage.init(named: "chap_video_icon")
    let completedVideoIcon = UIImage.init(named: "chap_completed_video_icon")
}
