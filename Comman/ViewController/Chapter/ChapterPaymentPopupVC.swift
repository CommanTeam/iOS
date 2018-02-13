//
//  ChapterPaymentVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 6..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class ChapterPaymentPopupVC: UIViewController {
    @IBOutlet weak var popUpInnerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpInnerView.addInnerShadow(onSide: .bottom, shadowColor: .black, shadowSize: 10.0, shadowOpacity: 0.15)
    }
    @IBAction func paymentBtn(_ sender: Any) {
    }
    
    @IBAction func popUpCloseBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func outerViewTapGesture(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
