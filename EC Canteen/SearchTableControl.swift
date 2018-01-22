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

class MyCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var distanceLabel: UILabel!
}

class SearchTableController: UITableViewController {
    
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
        Alamofire.request("http://projgw.cse.cuhk.edu.hk:2887/api/restaurants").responseJSON { response in
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
                }
            }
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! MyCustomTableViewCell
        
        cell.textLabel?.text = restaurants[indexPath.row]["name"].string
        if (restaurants[indexPath.row]["is_opening"].boolValue) {
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
            let restaurantDetailController = segue.destination as! MapViewController
            restaurantDetailController.restaurantList = restaurants
        }
    }

}
