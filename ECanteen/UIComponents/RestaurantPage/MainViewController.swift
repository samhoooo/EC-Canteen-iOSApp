//
//  ViewController.swift
//  tonightEatWhat
//
//  Created by Joker on 4/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Alamofire
import SwiftyJSON
import UserNotifications

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var UI_PlayVideo: UIView!
    @IBOutlet weak var saveRecipeButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionTextView: UILabel!
    @IBOutlet weak var addressTextView: UILabel!
    @IBOutlet weak var workingHourTextView: UILabel!
    @IBOutlet weak var telephoneTextView: UILabel!
    @IBOutlet weak var canteenPhotoImageView: UICollectionView!
    @IBOutlet weak var openTextView: UILabel!
    
    var startingFrame: CGRect?
    var blackbackgroundView: UIView?
    
    var meals = [Meal]() //Array storing meals provided
    var canteen_id:Int = 0
    var canteen_name = ""
    
    @IBAction func imageTap(_ sender: UITapGestureRecognizer) {
        let startingImageView = sender.view as! UIImageView
        self.startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        
        let zoomingImageView = UIImageView(frame: self.startingFrame!)
        zoomingImageView.backgroundColor = UIColor.red
        zoomingImageView.image = startingImageView.image //set image
        zoomingImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleZoomOutofImage)) //add tapgesture recognizer
        zoomingImageView.addGestureRecognizer(tapGestureRecognizer)
        
        self.view.isHidden = true //hide current main view first
        if let keyWindow = UIApplication.shared.keyWindow{
            //add black background view
            self.blackbackgroundView = UIView(frame: keyWindow.frame)
            self.blackbackgroundView?.backgroundColor = UIColor.black
            self.blackbackgroundView?.alpha = 0  //before animation set alpha to 0
            keyWindow.addSubview(self.blackbackgroundView!)
            
            keyWindow.addSubview(zoomingImageView) //add subview of the zoomed image
            
            //animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackbackgroundView?.alpha = 1 //set alpha to 1
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width  //h2/w2 = h1/w1
                zoomingImageView.frame = CGRect(x:0, y:0, width:keyWindow.frame.width, height:height)
                zoomingImageView.center = keyWindow.center
            }, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc: mealTableViewController = segue.destination as! mealTableViewController
            vc.canteen_id = canteen_id
            vc.canteen_name = canteen_name
    }
    
    func handleZoomOutofImage(tapGesture: UITapGestureRecognizer){
        if let zoomOutImageView = tapGesture.view{
            //animate back out to controller
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                zoomOutImageView.frame = self.startingFrame!
                self.blackbackgroundView?.alpha = 0
                self.view.isHidden = false
            }, completion: {
                (completed:Bool) in
                zoomOutImageView.removeFromSuperview()
            })
        }
    }
    
    var imageArray = [UIImage(named:"coffeecon1"),UIImage(named:"coffeecon2"),UIImage(named:"coffeecon3"),UIImage(named:"coffeecon4"),]
    //var imageArray = [UIImage]()
    let videoURL = "http://appsrv.cse.cuhk.edu.hk/~ktho5/recipe/christmas_song.mp4"
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoURL = URL(string: self.videoURL)
        self.player = AVPlayer(url:videoURL!)
        let playerViewController = AVPlayerViewController()

        playerViewController.player = self.player
        playerViewController.view.frame = UI_PlayVideo.frame
        playerViewController.view.bounds = UI_PlayVideo.bounds
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addChildViewController(playerViewController)
        //UI_PlayVideo.isHidden = true
        self.UI_PlayVideo.insertSubview(playerViewController.view, at: 1)
        
        //add constraint
        let bottomConstraint = NSLayoutConstraint(item: playerViewController.view, attribute: .bottom, relatedBy: .equal, toItem: self.UI_PlayVideo, attribute: .bottom, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: playerViewController.view, attribute: .top, relatedBy: .equal, toItem: self.UI_PlayVideo, attribute: .top, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: playerViewController.view, attribute: .leading, relatedBy: .equal, toItem: self.UI_PlayVideo, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: playerViewController.view, attribute: .trailing, relatedBy: .equal, toItem: self.UI_PlayVideo, attribute: .trailing, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([bottomConstraint,topConstraint,leadingConstraint,trailingConstraint])
        
        //load restaurant info
        Alamofire.request("http://projgw.cse.cuhk.edu.hk:2887/api/restaurants/"+String(self.canteen_id),method: .get).responseJSON { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("ViewController:  success in loading restaurant data")
                default:
                    print("ViewController:  error with response status: \(status)")
                }
            }
            
            if response.result.value != nil {
                if response.result.isSuccess {
                    do{
                        let json: JSON = try JSON(data: response.data!)
                        
                        print(json["name"].stringValue)
                        print(json["address"].stringValue)
                        print(json["description"].stringValue)
                        print(json["telephone"].stringValue)
                        print(json["working_hour"].stringValue)
                        
                        if let photoList = json["photo"].array{
                            for photo in photoList{
                                let photoURL = URL(string: "http://projgw.cse.cuhk.edu.hk:2887/api/restaurants/"+String(self.canteen_id)+"/resources/"+String(photo.stringValue))
                                
                                //download the photo
                                let session = URLSession(configuration: .default)
                                let downloadPicTask = session.dataTask(with: photoURL!) { (data, response, error) in
                                    print("on9")
                                    if let e = error {
                                        print("Error downloading canteen picture: \(e)")
                                    } else {
                                        // No errors found.
                                        // It would be weird if we didn't have a response, so check for that too.
                                        if let res = response as? HTTPURLResponse {
                                            print("Downloaded canteen picture with response code \(res.statusCode)")
                                            if let imageData = data {
                                                // Finally convert that Data into an image and do what you wish with it.
                                                print(UIImage(data: imageData) ?? "Image not Available")
                                                self.imageArray.insert(UIImage(data: imageData)!,at:0)
                                                // Do something with your image.
                                                print(self.imageArray)
                                                self.canteenPhotoImageView.reloadData()
                                            } else {
                                                print("Couldn't get image: Image is nil")
                                            }
                                        } else {
                                            print("Couldn't get response code for some reason")
                                        }
                                    }
                                }
                                downloadPicTask.resume()
                            }
                        }
                        
                        if(json["description"].stringValue.isEmpty){
                            self.descriptionTextView.text = "沒有餐廳簡介"
                        }else{
                            self.descriptionTextView.text = json["description"].stringValue
                        }
                        
                        self.addressTextView.text = json["address"].stringValue
                        self.telephoneTextView.text = json["telephone"].stringValue
                        self.workingHourTextView.text = json["working_hour"].stringValue
                        if(json["isOpening"]["status"].boolValue==false){
                                self.openTextView.text = "CLOSED"
                                self.openTextView.backgroundColor = UIColor(red: 206/255, green: 60/255, blue: 62/255, alpha: 1.0)
                        }else{
                                self.openTextView.text = "OPEN"
                                self.openTextView.backgroundColor = UIColor(red: 103/255, green: 150/255, blue: 69/255, alpha: 1.0)
                        }

                        
                        //print(self.imageArray)
                        self.canteenPhotoImageView.reloadData()
                        
                        //print(self.productsAndPrices)
                        //self.tableView.reloadData()
                    }catch{
                        print(error)
                    }
                }
            }
        }
        UNUserNotificationCenter.current().delegate = self //enable foreground app notification
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Specifing the uber of cells in the giving section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            //showing pictures
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as!
            ImageCollectionViewCell
            cell.imgImage.image = imageArray[indexPath.row]
            
            //add tap gesture recognizer
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTap))
            cell.imgImage.addGestureRecognizer(tapGestureRecognizer)
            cell.imgImage.isUserInteractionEnabled = true
            return cell
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.dismiss(animated: true, completion: nil)
        self.player.pause()
    }
    
}

extension ViewController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
