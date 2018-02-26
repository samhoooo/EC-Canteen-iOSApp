//
//  SearchTableControl.swift
//  EC Canteen
//
//  Created by John on 21/1/2018.
//  Copyright © 2018年 MHW1701. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import CoreLocation
import UserNotifications

class MyCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var distanceLabel: UILabel!
}

class SearchTableController: UITableViewController, UIApplicationDelegate {
    
    var restaurants = [JSON]()
    
    var selectedRestaurantID: Int = 0
    
    var userLocation:UserLocation = UserLocation()
    
    
    @IBAction func loadMapView(_ sender: Any) {
        print ("clicked")
        performSegue(withIdentifier: "MapViewSegue", sender: self)
    }
    
    override func viewDidLoad() {
        self.refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
            userLocation.setGetLocationCallback(callback: {
            self.sortData()
        })
        fetchData()
        userLocation.determineMyCurrentLocation()
        UNUserNotificationCenter.current().delegate = self //enable foreground app notification
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func sortData(){
        func sortByDistance (a: JSON, b: JSON) -> Bool {
            return a["distance"] < b["distance"]
        }
        
        self.restaurants = self.restaurants.sorted(by: sortByDistance)
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    private func fetchData() {
        Alamofire.request("\(Constants.API_BASE)/restaurants").responseJSON { response in
            if let data = response.data {
                do {
                    self.restaurants = [JSON]()
                    var json = try JSON(data: data)
                    for i in 0...(json.count-1) {
                        let subJson = json[i]
                        json[i]["distance"].double = self.userLocation.getDistance(from: CLLocation(latitude: subJson["latitude"].doubleValue, longitude: subJson["longitude"].doubleValue))
                        self.restaurants.append(json[i])
                    }
                    
                    self.sortData()
                    
                } catch {
                    print("Error: \(error)")
                    let alert = UIAlertController(title: "My Alert", message: NSLocalizedString("VPN not enabled", comment: "Alert Box"), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Default action"), style: .cancel, handler: { _ in
                        do {
                            try PreferencesExplorer.open(.ringtone)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchData()
        userLocation.determineMyCurrentLocation()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! MyCustomTableViewCell
        
        cell.textLabel?.text = restaurants[indexPath.row]["name"].string
        if (restaurants[indexPath.row]["isOpening"]["status"].boolValue) {
            cell.detailTextLabel?.text =  "OPENING"
        } else {
            cell.detailTextLabel?.text =  "CLOSED"
        }
        cell.distanceLabel?.text = String(format:"%.0f m", restaurants[indexPath.row]["distance"].doubleValue)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRestaurantID = restaurants[indexPath.row]["restaurantid"].intValue
        // Segue to the second view controller
        self.performSegue(withIdentifier: "RestaurantDetailSegue", sender: self)
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier != "MapViewSegue") {
            let restaurantDetailController = segue.destination as! RestaurantDetailController
            
            // set a variable in the second view controller with the data to pass
            restaurantDetailController.canteen_id = selectedRestaurantID
        } else {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.restaurantList = restaurants
        }
    }

}

extension SearchTableController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // notifications.getMyNotifcations(v: self.view)
        print("a")
        switch (response.notification.request.content.userInfo["notiType"] as! String) {
        case "take_order":
            print("a")
            notifications.getMyNotifcations(v: self.view, payload: response.notification.request.content.userInfo)
            break
            
        default:
            print("???")
            break
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Capture payload here something like:
        print("b")
        switch (userInfo["notiType"] as! String) {
        case "take_order":
            notifications.getMyNotifcations(v: self.view, payload: userInfo)
            break
            
        default:
            print("???")
            break
        }
        
        completionHandler(.noData)
        
    }
}
