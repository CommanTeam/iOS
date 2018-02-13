//
//  ChapterWithoutVideoCell.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 5..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class ChapterWithoutVideoCell: UITableViewCell {
    @IBOutlet weak var lecVideoImg: UIImageView!
    @IBOutlet weak var infoBackView: UIView!
    @IBOutlet weak var mainLectureTitle: UILabel!
    @IBOutlet weak var subLectureTitle: UILabel!
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var chapIconImg: UIImageView!
    @IBOutlet weak var displayLabel: UILabel!
    
    let quizIcon: UIImage = #imageLiteral(resourceName: "chap_play_quiz_icon")
    let pictureIcon: UIImage = #imageLiteral(resourceName: "chap_play_picture_icon")
}
