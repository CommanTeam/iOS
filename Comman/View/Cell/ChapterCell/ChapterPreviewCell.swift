//
//  ChapterPreviewCell.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 9..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit
import YouTubePlayer

class ChapterPreviewCell: UITableViewCell {
    @IBOutlet weak var viewLargeBtn: UIButton!
    @IBOutlet weak var previewPlayer: YouTubePlayerView!
    @IBOutlet weak var previewPlayBtn: UIButton!
    @IBOutlet weak var previewPauseBtn: UIButton!
    @IBOutlet weak var previewProgressBar: CustomSlider!
    @IBOutlet weak var previewLectureTitle: UILabel!
    @IBOutlet weak var curMinLabel: UILabel!
    @IBOutlet weak var curSecLabel: UILabel!
    @IBOutlet weak var allMinLabel: UILabel!
    @IBOutlet weak var allSecLabel: UILabel!
    
    var videoID: String = ""
    var videoDuration: Int = 0
    var curMin = 0
    var curSec = 0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func playBtnAction(_ sender: Any) {
        previewPlayer.play()
        let delayInSeconds = 1.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.setVideoSlider), userInfo: nil, repeats: true)
        }
        
    }
    @IBAction func pauseBtnAction(_ sender: Any) {
        previewPlayer.pause()
    }
    @IBAction func videoSliderAction(_ sender: CustomSlider) {
        previewPlayer.seekTo(sender.value, seekAhead: true)
    }
    
    @objc func setVideoSlider() {
        curSec += 1
        self.previewProgressBar.value = Float(curSec)
        if curSec > 59 {
            curSec = 0
            curMin += 1
            if curMin > 10 {
                curMinLabel.text = "\(curMin)"
            } else {
                curMinLabel.text = "0\(curMin)"
            }
        } else {
            if curSec > 10 {
                curSecLabel.text = "\(curSec)"
            } else {
                curSecLabel.text = "0\(curSec)"
            }
        }
    }
}


