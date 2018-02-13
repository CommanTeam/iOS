//
//  HomeWithVideoCell.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class HomeWithVideoCell: UITableViewCell {
    @IBOutlet weak var youtubeThumbnailImg: UIImageView!
    @IBOutlet weak var lecVideoProgressView: CustomProgressBar!
    @IBOutlet weak var infoBackView: UIView!
    @IBOutlet weak var mainLectureTitle: UILabel!
    @IBOutlet weak var subLectureTitle: UILabel!
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var chapIconImg: UIImageView!
    @IBOutlet weak var displayLabel: UILabel!
    
    let videoIcon: UIImage = #imageLiteral(resourceName: "chap_play_video_icon")
}
