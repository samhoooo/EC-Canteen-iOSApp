//
//  PageDotViewController.swift
//  tonightEatWhat
//
//  Created by Sam on 21/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class PageDotViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageControlContainer: UIView!
    
    var restaurantId = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? PageViewController {
            tutorialPageViewController.tutorialDelegate = self
            tutorialPageViewController.restaurantId = restaurantId
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = String(restaurantId)
        let button1 = UIBarButtonItem(image: UIImage(named: "BookmarkRibbon"), style: .plain, target: self, action: #selector(saveRecipe(sender:))) // action:#(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    func saveRecipe(sender: UIBarButtonItem) {
        let image = sender.image
        
        if(image==UIImage(named:"BookmarkRibbon"))
        {
            sender.image = UIImage(named: "BookmarkRibbonFilled")
        }
        else if(image==UIImage(named:"BookmarkRibbonFilled"))
        {
            sender.image = UIImage(named: "BookmarkRibbon")
        }
        
        if(image==UIImage(named:"comment"))
        {
            //Show pop up window
            let popOverVC = UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
            //navigation controller disable
            self.navigationController?.isNavigationBarHidden = true
        }
    }
}

extension PageDotViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: PageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: PageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        
        if(index==1){
            //stop playing video
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "comment")
        }else{
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "BookmarkRibbon")
        }
    }
    
}

