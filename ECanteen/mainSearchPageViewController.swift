//
//  mainSearchPageViewController.swift
//  tonightEatWhat
//
//  Created by Joker on 4/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import CoreLocation

class mainSearchPageViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var foodBox: UIView!
    @IBOutlet weak var seasoningBox: UIView!
    @IBOutlet weak var styleBox: UIView!
    @IBOutlet weak var difficultyBox: UIView!
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet var mapView: GMSMapView!
    
    var canteenNameToId = [String:Int]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude:  22.418566, longitude:114.205568, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        self.view = mapView
        //self.view.addSubview(self.mapView)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        Alamofire.request("http://projgw.cse.cuhk.edu.hk:2887/api/restaurants/",method: .get).responseJSON { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            
            if response.result.value != nil {
                if response.result.isSuccess {
                    do{
                        let json: JSON = try JSON(data: response.data!)
                        
                        if let restaurantList = json.array{
                            for restaurant in restaurantList{
                                print(restaurant["name"].stringValue)
                                print(restaurant["address"].stringValue)
                                print(restaurant["latitude"].doubleValue)
                                print(restaurant["longitude"].doubleValue)
                                print(restaurant["restaurantid"].intValue)
                                
                                self.canteenNameToId[restaurant["name"].string!] = restaurant["restaurantid"].int
                                
                                let marker = GMSMarker()
                                if(restaurant["isOpening"]["status"] == false){
                                    marker.icon = GMSMarker.markerImage(with: .black)
                                }
                                marker.position = CLLocationCoordinate2D(latitude:restaurant["latitude"].doubleValue, longitude:restaurant["longitude"].doubleValue)
                                marker.title = restaurant["name"].string
                                marker.snippet = restaurant["address"].stringValue + "\n 點按圖標以查看詳細資料"
                                marker.map = self.mapView
                            }
                        }
                        //print(self.productsAndPrices)
                        //self.tableView.reloadData()
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("tapped!")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPageViewController = storyBoard.instantiateViewController(withIdentifier:"asd") as! PageDotViewController
        mainPageViewController.canteen_name = marker.title!
        mainPageViewController.canteen_id = canteenNameToId[marker.title!]!
        self.show(mainPageViewController, sender: self)
    }
    
    //call when every time user changes his/her location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        print(CLLocationCoordinate2DMake(newLocation!.coordinate.latitude, newLocation!.coordinate.longitude))
        let camera = GMSCameraPosition.camera(withLatitude: (newLocation!.coordinate.latitude), longitude:(newLocation!.coordinate.longitude), zoom:16)
        mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func goToIngredientsPage(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPageViewController = storyBoard.instantiateViewController(withIdentifier:"ingredientsPage")
        self.show(mainPageViewController, sender: self)
    }
    
    func goToSeasoningPage(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPageViewController = storyBoard.instantiateViewController(withIdentifier:"seasoningPage")
        self.show(mainPageViewController, sender: self)
    }
    
    func goToStylePage(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPageViewController = storyBoard.instantiateViewController(withIdentifier:"stylePage")
        self.show(mainPageViewController, sender: self)
    }
    
    func goToDifficultyPage(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainPageViewController = storyBoard.instantiateViewController(withIdentifier:"difficultyPage")
        self.show(mainPageViewController, sender: self)
    }
}
