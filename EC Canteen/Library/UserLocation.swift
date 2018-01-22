//
//  UserLocation.swift
//  EC Canteen
//
//  Created by John on 22/1/2018.
//  Copyright © 2018年 MHW1701. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocation: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    
    var userLocation: CLLocation
    
    var getLocationCallback: ()->() = {}
    
    override init() {
        self.userLocation = CLLocation()
    }
    
    func setGetLocationCallback (callback: @escaping ()->()) {
        self.getLocationCallback = callback
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        userLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        getLocationCallback()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("Start Check Location")
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func getDistance(from: CLLocation) -> CLLocationDistance {
        return userLocation.distance(from: from)
    }
    
    
    func sortByDistance (a: CLLocation, b: CLLocation) -> Bool{
        return userLocation.distance(from: a) < userLocation.distance(from: b)
    }
}
