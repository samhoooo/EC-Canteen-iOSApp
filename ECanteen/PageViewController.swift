//
//  PageViewController.swift
//  tonightEatWhat
//
//  Created by Sam on 21/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    weak var tutorialDelegate: TutorialPageViewControllerDelegate?
    
    var restaurantId = 0
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "Recipe"),
                UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "Comment"),]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            (firstViewController as! ViewController).restaurantId = restaurantId
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self,
                                                     didUpdatePageCount: orderedViewControllers.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self,
                                                         didUpdatePageIndex: index)
        }
    }
    
}

protocol TutorialPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     =
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func tutorialPageViewController(tutorialPageViewController: PageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tutorialPageViewController(tutorialPageViewController: PageViewController,
                                    didUpdatePageIndex index: Int)
    
}

