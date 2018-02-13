//
//  RootCardNewsPageVC.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 3..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import UIKit

class RootCardNewsPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self;
        dataSource = self
        self.setViewControllers([getViewControllerAtIndex(0)] as [UIViewController], direction: .forward, animated: true, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: CardNewsVC = viewController as! CardNewsVC
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1;
        return getViewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: CardNewsVC = viewController as! CardNewsVC
        
        var index = pageContent.pageIndex
        if (index == NSNotFound)
        {
            return nil;
        }
        index += 1;
        return getViewControllerAtIndex(index)
    }
    
    func getViewControllerAtIndex(_ index: Int) -> CardNewsVC {
        
        // Create a new view controller and pass suitable data.
        // 이 곳에서 다음 페이지에 출력할 내용을 대입
        let cnvc = self.storyboard?.instantiateViewController(withIdentifier: "CardNewsVC") as! CardNewsVC
        cnvc.lastCardNews = true
        return cnvc
    } // Generic으로 만들어서 모든 뷰를 대응할 것인지 아니면 각각의 뷰에 대응하는 함수를 만들어서 분기로 호출하든지 앱잼 기간인 만큼 각각의 함수로 나누는 것이 좋다고 봄
}

