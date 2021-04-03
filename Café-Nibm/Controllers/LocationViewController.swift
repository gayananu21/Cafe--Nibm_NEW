//
//  LocationViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/8/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager?
    
    var latitude = ""
    var longitude = ""
    var distance = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
               
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                  let VC1 = storyBoard.instantiateViewController(withIdentifier: "HOME_TAB") as! Home_Tab_ViewController
               

                       self.navigationController?.pushViewController(VC1, animated: true)
            default:
                print("...")
            }
        } else {
            print("Location services are not enabled")
        }
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func allowLocation(_ sender: Any) {
        
              locationManager = CLLocationManager()
              locationManager?.requestAlwaysAuthorization()
              locationManager?.startUpdatingLocation()
              
              

              if CLLocationManager.locationServicesEnabled() {
                  switch(CLLocationManager.authorizationStatus()) {
                  case .notDetermined, .restricted, .denied:
                      print("No access")
                     

                                            
                  case .authorizedAlways, .authorizedWhenInUse:
                      print("Access")
                      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                        let VC1 = storyBoard.instantiateViewController(withIdentifier: "HOME_TAB") as! Home_Tab_ViewController
                     

                             self.navigationController?.pushViewController(VC1, animated: true)
                  default:
                      print("...")
                  }
              } else {
                  print("Location services are not enabled")
              }
              
    }
    
    @IBAction func cancelLocation(_ sender: Any) {
        
        var storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                                              let VC1 = storyBoard.instantiateViewController(withIdentifier: "HOME_TAB") as! Home_Tab_ViewController
                                           

                                                   self.navigationController?.pushViewController(VC1, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            
            self.latitude = "Lat:\(location.coordinate.latitude)"
            self.longitude = "Lon:\(location.coordinate.longitude)"
            
            //My location
            let myLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

                 //My Next Destination
                 let myNextDestination = CLLocation(latitude: 7.290712814881615, longitude: 80.63333386362791)

                 //Finding my distance to my next destination (in km)
                 let distance = myLocation.distance(from: myNextDestination) / 1000
            self.distance = String(distance)
            
        }
        
             
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
