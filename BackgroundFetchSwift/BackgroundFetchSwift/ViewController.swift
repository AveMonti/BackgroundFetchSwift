//
//  ViewController.swift
//  BackgroundFetchSwift
//
//  Created by Mateusz Chojnacki on 8/24/18.
//  Copyright © 2018 TomTom. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.00, 0.00)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LOCATION SETUP
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.allowsBackgroundLocationUpdates = true
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if error != nil {
                print("Authorization Unsuccessfull")
            }else {
                print("Authorization Successfull")
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

            self.currentLocation = center
        }
    }

    func backgroundAnnotation(){
        let contentNottyfication = UNMutableNotificationContent()
        contentNottyfication.title = "5sec"
        contentNottyfication.subtitle = "xD"
        contentNottyfication.body = "Ilość \(self.currentLocation.latitude), \(self.currentLocation.longitude)"
        contentNottyfication.badge = 1

        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "timer done", content: contentNottyfication, trigger: triger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}

