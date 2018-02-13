//
//  QuizWithOutImageVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 1..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {
    @IBOutlet weak var quizTableView: UITableView!
    var pageIndex: Int = 0
    var cells:[IndexPath] = [IndexPath]()
    let list = ["보기 > 디자인 설정 > 여백 바꾸기", "보기 > 디자인 설정 > 여백 바꾸기", "보기 > 디자인 설정 > 여백 바꾸기", "보기 > 디자인 설정 > 여백 바꾸기", "보기 > 디자인 설정 > 여백 바꾸기"]
    let imageURL = "https://assets.pcmag.com/media/images/482504-google-logo.jpg?thumb=y&width=810&height=456"
//    let imageURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        quizTableView.delegate = self
        quizTableView.dataSource = self
    }
}

extension QuizVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? QuizMultipleChoiceCell else {
            return
        }
        if cell.check == true {
            cell.contentView.backgroundColor = UIColor.clear
            cell.multipleChoiceNumLabel.textColor = cell.multipleChoiceDefaultTextColor
            cell.multipleChoiceNumTagLabel.textColor = cell.multipleChoiceDefaultTextColor
            cell.multipleChoiceContentLabel.textColor = cell.multipleChoiceDefaultTextColor
            cell.multipleChoiceView.backgroundColor = cell.multipleChoiceDefaultBgViewColor
            cell.check = false
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        } else {
            guard let cell = tableView.cellForRow(at: indexPath) as? QuizMultipleChoiceCell else {
                return
            }
            if cell.check == false {
                cell.contentView.backgroundColor = UIColor.clear
                cell.multipleChoiceNumLabel.textColor = cell.multipleChoiceSelectTextColor
                cell.multipleChoiceNumTagLabel.textColor = cell.multipleChoiceSelectTextColor
                cell.multipleChoiceContentLabel.textColor = cell.multipleChoiceSelectTextColor
                cell.multipleChoiceView.backgroundColor = cell.multipleChoiceSelectBgViewColor
                cell.check = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list.isEmpty {
            return 1
        } else {
            if imageURL == "" {
                return list.count + 1
            } else {
                return list.count + 2
            }
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuizMultipleChoiceCell", for: indexPath) as! QuizMultipleChoiceCell
                cell.multipleChoiceNumLabel.text = "\(indexPath.row)"
                cell.multipleChoiceContentLabel.text = list[indexPath.row - 1]
                cell.selectionStyle = .none
                cells.append(indexPath)
                return cell
            } else {
                if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "QuizContentImageCell", for: indexPath) as! QuizContentImageCell
                    cell.quizContentImageView.imageFromUrl(imageURL, defaultImgPath: "")
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "QuizMultipleChoiceCell", for: indexPath) as! QuizMultipleChoiceCell
                    cell.multipleChoiceNumLabel.text = "\(indexPath.row - 1)"
                    cell.multipleChoiceContentLabel.text = list[(indexPath.row) - 2]
                    cell.selectionStyle = .none
                    cells.append(indexPath)
                    return cell
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        } else {
            if imageURL == "" {
                return indexPath
            } else {
                if indexPath.row == 1 {
                    return nil
                } else {
                    return indexPath
                }
            }
        }
    }
}
