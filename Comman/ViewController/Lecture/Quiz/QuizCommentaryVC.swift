//
//  QuizCommentaryVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 3..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class QuizCommentaryVC: UIViewController {
    var mainCurNum: Int = 0
    var pageCountCurNum: Int = 0
    var pageCountAllNum: Int = 0
    var quizContent: String = ""
    var resultNum: Int = 0
    var commantary: String = ""
//    var imageURL:String = ""
    let imageURL = "https://assets.pcmag.com/media/images/482504-google-logo.jpg?thumb=y&width=810&height=456"
    
    @IBOutlet weak var commentaryInnerView: UIView!
    @IBOutlet weak var commentaryOuterView: UIView!
    @IBOutlet weak var quizCommentaryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizCommentaryTableView.delegate = self
        quizCommentaryTableView.dataSource = self
        commentaryInnerView.addInnerShadow(onSide: .bottom, shadowColor: .black, shadowSize: 10.0, shadowOpacity: 0.15)
    }
    
    @IBAction func popUpCloseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension QuizCommentaryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if imageURL == "" {
            return 2
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizContentCell", for: indexPath) as! QuizContentCell
            cell.mainTextLabel.text = "12"
            cell.pageCountCurLabel.text = "12"
            cell.pageCountAllLabel.text = "23"
            cell.quizContentLabel.text = "다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오."
            cell.selectionStyle = .none
            return cell
        } else {
            if imageURL == "" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCommnetaryCell", for: indexPath) as! QuizCommnetaryCell
                cell.resultNumLabel.text = "정답 : 3번"
                cell.commantaryLabel.text = "해설 : 다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중"
                cell.selectionStyle = .none
                return cell
            } else {
                if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "QuizContentImageCell", for: indexPath) as! QuizContentImageCell
                    cell.quizContentImageView.imageFromUrl(imageURL, defaultImgPath: "")
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCommnetaryCell", for: indexPath) as! QuizCommnetaryCell
                    cell.resultNumLabel.text = "정답 : 3번"
                    cell.commantaryLabel.text = "해설 : 다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중, 문서의 여백을 설정할 수 있는 방법으로 옳은 것을 고르시오.다음 중"
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
    }
}
