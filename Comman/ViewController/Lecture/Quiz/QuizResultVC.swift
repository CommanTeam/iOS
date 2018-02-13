//
//  QuizResultVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 2..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation
import UIKit
class QuizResultVC: UIViewController {
    var pageIndex: Int = 2
    @IBOutlet weak var quizResultTableView: UITableView!
    var list = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    override func viewDidLoad() {
        super.viewDidLoad()
        quizResultTableView.delegate = self
        quizResultTableView.dataSource = self
    }
}

extension QuizResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list.isEmpty {
            return 1
        } else {
            return list.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizResultCell", for: indexPath) as! QuizResultCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizMultipleResultCell", for: indexPath) as! QuizMultipleResultCell
            cell.quizMultipleResultNumLabel.text = "\(indexPath.row - 1)"
            if (indexPath.row - 1) % 2 == 0 {
                cell.quizMultipleResultImgView.imageFromUrl("", defaultImgPath: "quiz_correct_mark")
            } else {
                cell.quizMultipleResultImgView.imageFromUrl("", defaultImgPath: "quiz_wrong_mark")
            }
            cell.selectionStyle = .none
            return cell
        }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        } else {
            guard let qcvc = storyboard?.instantiateViewController(withIdentifier: "QuizCommentaryVC") as? QuizCommentaryVC else{
                return
            }
            self.present(qcvc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        } else {
            return indexPath
        }
    }

}
