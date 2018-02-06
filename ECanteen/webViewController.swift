//
//  webViewController.swift
//  tonightEatWhat
//
//  Created by CCH on 16/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

/*********************
 * webViewController
 *
 * -> Purpose:
 *      To create a page that display web page content.
 *
 * -> Functionalities: 
 *      Enabled: back, forward, refresh, share (action), copy URL
 *      Disabled: manually go to other webpages by typing URL
 *
 * -> How to use:
 *      1. Set a new ViewController:
 *           >> let webVC = storyboard?.instantiateViewController(withIdentifier: "vc_web") as! webViewController
 *      2. Set up View title and urlPath
 *           >> webVC.title = "標題"
 *           >> webVC.urlPath = "location.php"
 *         Note: urlPath is within the specified website (urlPrefix) in webViewController.swift
 *      3. Push the ViewController:
 *           >> navigationController?.pushViewController(webVC, animated: true)
 *
 *      Note: For tableViewCells, override func tableView(_ tableView, didSelectRowAt indexPath), then select the cell by
 *              >> let cell = super.tableView(tableView, cellForRowAt: indexPath)
 *              >> if cell = ...
 *              to open a new webView by clicking on a table cell.
 *
 * -> Example:
 *      https://gist.github.com/cch0074/450e2731b4814f4d74f8bed63084eba4
 *********************/

import UIKit

class webViewController: UIViewController, UIWebViewDelegate {
    
    // Prefix of the URL (website link). Using CSE website temporarily
    var urlPrefix = "https://appsrv.cse.cuhk.edu.hk/~hchan5/recipe/"
    // Path of the target page. Decided by caller (Leave it blank here)
    var urlPath = ""
    
    // MARK: Properties
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var button_back: UIButton!
    @IBOutlet weak var button_next: UIButton!
    @IBOutlet weak var textField_address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadURL(self.webview)
        self.textField_address.text = urlPrefix + urlPath
        checkButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func onBackTapped(_ sender: Any) {
        self.webview.goBack()
    }
    @IBAction func onNextTapped(_ sender: Any) {
        self.webview.goForward()
    }
    @IBAction func onRefreshTapped(_ sender: Any) {
        self.webview.reload()
    }
    
    // Enable or disable back and next buttons
    func checkButtons() {
        if self.webview.canGoBack {
            self.button_back.isEnabled = true
        } else {
            self.button_back.isEnabled = false
        }
        if self.webview.canGoForward {
            self.button_next.isEnabled = true
        } else {
            self.button_next.isEnabled = false
        }
    }
    
    // Load web page content according to the path given
    func loadURL(_ webView: UIWebView) {
        webView.delegate = self
        let requestURL = URL(string: urlPrefix + urlPath)
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }
    
    // Load URL to address textField
    func loadAddress(webView: UIWebView, addressField: UITextField) {
        addressField.text = webView.request?.url?.absoluteString
    }
    
    // Load current URL to the address textField
    // Using UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadAddress(webView: webView, addressField: self.textField_address)
    }
    
    // Refresh button status after each time a page is loaded
    // Using UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadAddress(webView: webView, addressField: self.textField_address)
        checkButtons()
    }
    
    // Share current URL by the action button
    @IBAction func onShareTapped(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [urlPrefix + urlPath], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
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
