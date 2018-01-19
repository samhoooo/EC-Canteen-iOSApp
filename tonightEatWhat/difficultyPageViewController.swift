//
//  difficultyPageViewController.swift
//  tonightEatWhat
//
//  Created by Joker on 4/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class difficultyPageViewController: UIViewController {

    @IBOutlet weak var normalLevel: UIImageView!
    @IBOutlet weak var hardLevel: UIImageView!
    @IBOutlet weak var easyLevel: UIImageView!
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //init difficulty icon
        if let easyClicked = defaults.value(forKey: "easyLevel"){
            if easyClicked as? Bool == nil {
                easyLevel.image = UIImage(named: "Settings Filled")
                defaults.set(true, forKey: "easyLevel")
            }
            else{
                if easyClicked as! Bool == true{
                    easyLevel.image = UIImage(named: "Settings Filled")
                }
                else{
                    easyLevel.image = UIImage(named: "Settings")
                }
            }
        }
        
        if let normalClicked = defaults.value(forKey: "normalLevel"){
            if normalClicked as? Bool == nil {
                normalLevel.image = UIImage(named: "Settings Filled")
                defaults.set(true, forKey: "normalLevel")
            }
            else{
                if normalClicked as! Bool == true{
                    normalLevel.image = UIImage(named: "Settings Filled")
                }
                else{
                    normalLevel.image = UIImage(named: "Settings")
                }
            }
        }
        
        if let hardClicked = defaults.value(forKey: "hardLevel"){
            if hardClicked as? Bool == nil {
                hardLevel.image = UIImage(named: "Settings Filled")
                defaults.set(true, forKey: "hardLevel")
            }
            else{
                if hardClicked as! Bool == true{
                    hardLevel.image = UIImage(named: "Settings Filled")
                }
                else{
                    hardLevel.image = UIImage(named: "Settings")
                }
            }
        }
        
        
        //add tap action to difficulty icon
        easyLevel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeEasyIcon)))
        normalLevel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeNormalIcon)))
        hardLevel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeHardIcon)))
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //change difficulty icon function
    func changeEasyIcon(){
        if defaults.value(forKey: "easyLevel") as? Bool == false{
            easyLevel.image = UIImage(named: "Settings Filled")
            defaults.set(true, forKey: "easyLevel")
        }
        else{
            easyLevel.image = UIImage(named: "Settings")
            defaults.set(false, forKey: "easyLevel")
        }
    }
    
    func changeNormalIcon(){
        if defaults.value(forKey: "normalLevel") as? Bool == false{
            normalLevel.image = UIImage(named: "Settings Filled")
            defaults.set(true, forKey: "normalLevel")
        }
        else{
            normalLevel.image = UIImage(named: "Settings")
            defaults.set(false, forKey: "normalLevel")
        }
    }
    
    func changeHardIcon(){
        if defaults.value(forKey: "hardLevel") as? Bool == false{
            hardLevel.image = UIImage(named: "Settings Filled")
            defaults.set(true, forKey: "hardLevel")
        }
        else{
            hardLevel.image = UIImage(named: "Settings")
            defaults.set(false, forKey: "hardLevel")
        }
    }
}
