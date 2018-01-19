//
//  loginViewController.swift
//  tonightEatWhat
//
//  Created by CCH on 17/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
    // MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func onFakeLogin(_ sender: Any) {
        UserDefaults.standard.set("Ronald", forKey: "username")
        UserDefaults.standard.set("Facebook", forKey: "platform")
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
