//
//  RootQuizPageVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 1..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class RootQuizPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    let userDefaults = UserDefaults.standard
    
    var lectureID: Int = 0
    var pageIndex: Int = 0
    var allPageIndex: Int = 0
    var baseNetworkModel: LectureNetworkModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self;
        dataSource = self
        guard let quizVC = self.storyboard?.instantiateViewController(withIdentifier: "QuizVC") as? QuizVC,
              let quizResultVC = self.storyboard?.instantiateViewController(withIdentifier: "QuizResultVC") as? QuizResultVC,
              let quizRegisterVC = self.storyboard?.instantiateViewController(withIdentifier: "QuizRegisterVC") as? QuizRegisterVC else {
            return
        }
        let vcs = [quizVC, quizRegisterVC, quizResultVC]
        self.setViewControllers([vcs[self.pageIndex]] as [UIViewController], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if ((self.pageIndex == 0) || (self.pageIndex == NSNotFound))
        {
            return nil
        }
        self.pageIndex -= 1;
        print("\(self.pageIndex) de")
        
        if self.pageIndex == self.allPageIndex {
            return getQuizRegisterVCAtIndex(self.pageIndex)
        } else {
            return getQuizVCAtIndex(self.pageIndex)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (self.pageIndex == NSNotFound)
        {
            return nil;
        }
        self.pageIndex += 1;
        
        print("\(self.pageIndex) in")
        if self.pageIndex == self.allPageIndex {
            return getQuizRegisterVCAtIndex(self.pageIndex)
        } else {
            return getQuizVCAtIndex(self.pageIndex)
        }
    }
    
    func getQuizVCAtIndex(_ index: Int) -> QuizVC {
        let qvc = self.storyboard?.instantiateViewController(withIdentifier: "QuizVC") as! QuizVC
        return qvc
    }
    
    func getQuizRegisterVCAtIndex(_ index: Int) -> QuizRegisterVC {
        let qvc = self.storyboard?.instantiateViewController(withIdentifier: "QuizRegisterVC") as! QuizRegisterVC
        return qvc
    }
    
    func getQuizResultVCAtIndex(_ index: Int) -> QuizResultVC {
        let qvc = self.storyboard?.instantiateViewController(withIdentifier: "QuizResultVC") as! QuizResultVC
        return qvc
    }
    
}
