//
//  SearchVC.swift
//  Comman
//
//  Created by Kiyong Shin on 04/01/2018.
//  Copyright © 2018 havetherain. All rights reserved.
//
import UIKit
import Alamofire

final class SearchVC: UIViewController, UIGestureRecognizerDelegate, NetworkCallback {
    let userDefaults = UserDefaults.standard
    let cellSpacingHeight: CGFloat = 13
    
    
    var searchModel : SearchNetworkModel!
    
    var selectedCourseID : Int  = 1
    var collectionData: [CateListVO] = [CateListVO]()
    var tableData: [SearchResultListVO] = [SearchResultListVO]()
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var courseListTable: UITableView!
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchBarBG: UIImageView!
    
    @IBOutlet weak var courseCollectionListView: UIView!
    @IBOutlet weak var courseTableListView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        courseListTable.delegate = self
        courseListTable.dataSource = self
        
        searchBarBG.layer.cornerRadius = 18.0
        searchBarBG.layer.masksToBounds = true
        
        searchBar.delegate = self as? UITextFieldDelegate
        
        cancelBtn.layer.cornerRadius = 13.0
        cancelBtn.layer.masksToBounds = true
        cancelBtn.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap_mainview(_: )))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        self.searchModel = SearchNetworkModel(self)
        
        searchBar.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = true
        addNavBarImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.text = ""
        self.cancelBtn.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true);
        startContainerVC(selectedCourseID)
        if !(searchBar.text?.isEmpty)! {
            textFieldDidChange(searchBar)
        } else {
            let token = userDefaults.string(forKey: "token")
            self.searchModel.getCateCourseList(token: token!)
        }
    }

    func addNavBarImage() {
        let navController = navigationController!
        
        let image = UIImage.init(named: "navigation_logo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth/2, height: bannerHeight/2)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
        self.navigationController?.navigationItem.titleView = imageView
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) ->
        Bool {
            if ((touch.view?.isDescendant(of: courseCollectionListView))!
                || (touch.view?.isDescendant(of: courseTableListView))!
                ){
                return false
            }
            else{
                return true
            }
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "getCateCourseList" {
            self.collectionData = resultData as! [CateListVO]
            self.categoryCollection.reloadData()
        } else if code == "getSearchResultList" {
            self.tableData = resultData as! [SearchResultListVO]
            self.courseListTable.reloadData()
        }
    }
    
    func startContainerVC(_ idx : Int) -> Void {
        self.courseCollectionListView.isHidden = false
        self.courseTableListView.isHidden = true
        switch idx {
        case 1:
            self.courseCollectionListView.isHidden = false
            break
        case 2:
            self.courseTableListView.isHidden = false
            break
        default:
            break
        }
    }
    
    @objc func handleTap_mainview(_ sender: UITapGestureRecognizer?) {
        self.searchBar.resignFirstResponder()
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        startContainerVC(1)
        searchBar.text = ""
        cancelBtn.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (searchBar.text?.isEmpty)! {
            startContainerVC(1)
            cancelBtn.isHidden = true
        } else {
            let token = userDefaults.string(forKey: "token")
            self.searchModel.getSearchResultList(token: token!, search: searchBar.text!)
            startContainerVC(2)
            cancelBtn.isHidden = false
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(note: NSNotification) {}
    
    @objc func keyboardWillHide(note: NSNotification) {}
}

extension SearchVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCollectionListCell", for: indexPath) as! CourseCollectionListCell
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 10.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        if collectionData[indexPath.row].categoryName == "IT 기기 기초" {
            cell.pictogramImg.image = UIImage.init(named: "lecture_search_computer_mobile")
        }
        else if collectionData[indexPath.row].categoryName == "인터넷" {
            cell.pictogramImg.image = UIImage.init(named: "lecture_search_internet")
        }
        else if collectionData[indexPath.row].categoryName == "황혼프로젝트" {
            cell.pictogramImg.image = UIImage.init(named: "lecture_search_project")
        }
        else if collectionData[indexPath.row].categoryName == "디자인 툴" {
            cell.pictogramImg.image = UIImage.init(named: "lecture_search_design_tool")
        }
        else if collectionData[indexPath.row].categoryName == "문서" {
            cell.pictogramImg.image = UIImage.init(named: "lecture_search_document")
        }
        else if collectionData[indexPath.row].categoryName == "프로그래밍" {
            cell.pictogramImg.image = UIImage.init(named: "lecture_search_programing")
        }
        
        var info : String = ""
        let size : Int = collectionData[indexPath.row].title.count
        
        for idx in 0..<(size - 1) {
            info.append( collectionData[indexPath.row].title[idx] + ", ")
        }
        
        info.append( collectionData[indexPath.row].title[size-1])
        
        cell.cateID = collectionData[indexPath.row].categoryID
        cell.cateTitle.text = collectionData[indexPath.row].categoryName
        cell.courseTitle.text = info
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let token = userDefaults.string(forKey: "token")
        print(collectionData[indexPath.row].categoryID)
        self.searchModel.getSearchCategoryResult(token: token!, categoryID: collectionData[indexPath.row].categoryID)
        self.searchBar.text = collectionData[indexPath.row].categoryName
        self.cancelBtn.isHidden = false
        startContainerVC(2)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width / 2.0 // Display Two elements in a row.
        collectionViewSize.height = collectionViewSize.height / 2.0
        
        return collectionViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CateHeader", for: indexPath)
        return header
    }
}

extension SearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.courseListTable.dequeueReusableCell(withIdentifier: "CourseLabelCell") as! CourseLabelCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = self.courseListTable.dequeueReusableCell(withIdentifier: "CourseTableListCell") as! CourseTableListCell
            
            cell.courseImg.imageFromUrl(tableData[indexPath.row-1].image_path, defaultImgPath: "")
            cell.courseImg.customRadius(onSide: .left)
            
            cell.courseID = tableData[indexPath.row - 1].id
            cell.courseTitle.text = tableData[indexPath.row - 1].title
            cell.courseInfo.text = tableData[indexPath.row - 1].info
            
            guard let hitCnt = tableData[indexPath.row - 1].hit else {
                return UITableViewCell()
            }
            if hitCnt > 999 {
                cell.courseHit.text = "\(Double(hitCnt)/1000.0)천 명이 수강 중입니다."
            } else {
                cell.courseHit.text = "\(hitCnt) 명이 수강 중입니다."
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let chapter_storyboard = UIStoryboard(name: "Chapter", bundle: nil)
            guard let chapterVC = chapter_storyboard.instantiateViewController(withIdentifier: "ChapterVC") as? ChapterVC else { return }
            chapterVC.courseID = tableData[indexPath.row - 1].id
            chapterVC.titleString = tableData[indexPath.row - 1].title
            self.navigationController?.pushViewController(chapterVC, animated: true)
        }
    }
}
