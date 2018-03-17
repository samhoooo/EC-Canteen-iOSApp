//
//  PopUpViewController.swift
//  tonightEatWhat
//
//  Created by Sam on 25/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    
    
    @IBAction func closePopUp(_ sender: Any) {
        self.removeAnimate() //show animation of closing
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8) //set background transparent
        self.showAnimate() //show animation of pop up
        textField.becomeFirstResponder() // get focus of UItextView
        self.textField.delegate = self //set textviewdelegate to self for textviewdidchange
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0;
            self.view.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
        });
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished:Bool) in
            if(finished){
                self.view.removeFromSuperview()
            }
        });
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let length : Int = textField.text.count
        self.wordCountLabel.text = "剩 "+String(400 - length)+" 字"
        print("on9")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text.count==0)
        {
            if(textField.text.count != 0){
                return true
            }
        }
        else if(textField.text.count > 399)
        {
            return false
        }
        return true
    }

    @IBAction func submitComment(_ sender: Any) { //submit comment
        let alert = UIAlertController(title: "發送成功", message: "你已成功發送留言", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        self.removeAnimate() //show animation of closing
        self.navigationController?.isNavigationBarHidden = false
    }
}
