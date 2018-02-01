//
//  MapViewController.swift
//  EC Canteen
//
//  Created by John on 22/1/2018.
//  Copyright © 2018年 MHW1701. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    var restaurantList: [JSON] = []
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 22.420467, longitude: 114.207027, zoom: 15.5)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        for i in 0...(restaurantList.count-1) {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: restaurantList[i]["latitude"].doubleValue, longitude: restaurantList[i]["longitude"].doubleValue)
            marker.title = restaurantList[i]["name"].stringValue
            marker.snippet = restaurantList[i]["eng_name"].stringValue
            marker.userData = restaurantList[i]["restaurantid"].intValue
            if (!restaurantList[i]["isOpening"]["status"].boolValue) {
                marker.icon = GMSMarker.markerImage(with: .black)
            }
            marker.map = mapView
        }
        
    }
    
    var selectedRestaurantID = 0
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print(marker)
        selectedRestaurantID = marker.userData as! Int
        self.performSegue(withIdentifier: "RestaurantDetailFromMapSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier != "MapViewSegue") {
            let restaurantTabBarController = segue.destination as! RestaurantDetailController
            
            // set a variable in the second view controller with the data to pass
            restaurantTabBarController.canteen_id = selectedRestaurantID
        }
    }
}

