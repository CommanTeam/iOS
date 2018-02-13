//
//  HomeCoureListCell.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class HomeCourseListCell: UITableViewCell {
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var countChapterLabel: UILabel!
    @IBOutlet weak var progressRateLabel: UILabel!
    @IBOutlet weak var progressRateBar: CustomProgressBar!
    
    var courseID: Int = 0
}
