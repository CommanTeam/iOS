//
//  VideoVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 10..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit
import YouTubePlayer

class VideoVC: UIViewController {
    
    @IBOutlet weak var lectureVideoTitle: UILabel!
    @IBOutlet weak var chapterListNcommentTableView: UITableView!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var videoCurMinLabel: UILabel!
    @IBOutlet weak var videoCurSecLabel: UILabel!
    @IBOutlet weak var videoAllMinLabel: UILabel!
    @IBOutlet weak var videoAllSecLabel: UILabel!
    @IBOutlet weak var tabButtons: TabButtonsView!
    
    @IBAction func videoPlayBtn(_ sender: UIButton) {
    }
    @IBAction func videoPauseBtn(_ sender: UIButton) {
    }
    @IBAction func wideScreenBtn(_ sender: Any) {
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterListNcommentTableView.delegate = self
        chapterListNcommentTableView.dataSource = self
    }
}

extension VideoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return tabButtons
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 44.0
        }else {
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 8
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoExplainCell") as! VideoExplainCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoExplainCell") as! VideoExplainCell
            return cell
        }
    }
}

