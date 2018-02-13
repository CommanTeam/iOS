//
//  CourseListCell_3.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 7..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class CourseTableListCell : UITableViewCell{
    @IBOutlet weak var courseImg: UIImageView!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseInfo: UILabel!
    @IBOutlet weak var courseHit: UILabel!
    
    var courseID : Int = 0
}
