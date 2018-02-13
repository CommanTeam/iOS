//
//  CardNewsVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 3..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class CardNewsVC:UIViewController {
    var lastCardNews: Bool = false
    var pageIndex: Int = 0 
    
    @IBOutlet weak var cardNewsImageView: UIImageView!
    @IBOutlet weak var nextLectureBtn: BorderButton!
    @IBOutlet weak var pageCountCurLabel: UILabel!
    @IBOutlet weak var pageCountAllLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if lastCardNews == false {
            nextLectureBtn.isHidden = true
            cardNewsImageView.isHidden = false
        } else {
            nextLectureBtn.isHidden = false
            cardNewsImageView.isHidden = true
        }
    }
}
