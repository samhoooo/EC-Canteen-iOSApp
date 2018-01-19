//
//  settingPageViewController.swift
//  tonightEatWhat
//
//  Created by Joker on 4/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

var logged_in: Bool = false

class settingPageViewController: UITableViewController {
    
    // MARK: Properties
    @IBOutlet var tableView_setting: UITableView!
    @IBOutlet weak var cell_userinfo: UITableViewCell!
    @IBOutlet weak var cell_login: UITableViewCell!
    @IBOutlet weak var cell_kitchenware: UITableViewCell!
    @IBOutlet weak var cell_aboutapp: UITableViewCell!
    @IBOutlet weak var cell_linked_ac: UILabel!
    @IBOutlet weak var imageView_propic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Make propic circular
        imageView_propic.layer.cornerRadius = imageView_propic.frame.size.width/2
        imageView_propic.clipsToBounds = true
        
        // Display username
        if let username = UserDefaults.standard.object(forKey: "username") as? String {
            print ("Username: " + username)
            logged_in = true
            
        } else {
            print ("No username")
            logged_in = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Customize cell behaviour
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        switch cell {
        case cell_login:
            // Change to default height
            // TODO Show only if user is not login
            if (logged_in) {
                return 0
            } else {
                return 44
            }

        case cell_userinfo:
            // Hide userinfo cell
            // Source: Stackoverflow 8260267
            // TODO Hide only if user is not login
            if (logged_in) {
                if let username = UserDefaults.standard.object(forKey: "username") as? String {
                    cell_linked_ac.text = username
                }
                return 88
            } else {
                return 0
            }
            
        default:
            ()
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    // MARK: Actions
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let webVC = storyboard?.instantiateViewController(withIdentifier: "webView") as! webViewController
        let gridSelectorVC = storyboard?.instantiateViewController(withIdentifier: "GridSelectorView") as! gridSelectorViewController
        
        switch cell {
            case cell_login:
                temp_login(username: "Ronald")
                break
            case cell_userinfo:
                temp_logout()
                break
            case cell_kitchenware:
                gridSelectorVC.title = "訂購紀錄"
                navigationController?.pushViewController(gridSelectorVC, animated: true)
            break
            case cell_aboutapp:
                webVC.title = "關於程式"
                webVC.urlPath = "about.php"
                navigationController?.pushViewController(webVC, animated: true)
                break
        default:
            ()
        }
    }
    
    // Temporary functions to display login status
    func temp_login(username: String) {
        UserDefaults.standard.set("Ronald", forKey: "username")
        logged_in = true
        tableView_setting.reloadData()
    }
    func temp_logout() {
        UserDefaults.standard.removeObject(forKey: "username")
        logged_in = false
        tableView_setting.reloadData()
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
