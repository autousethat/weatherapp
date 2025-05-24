//
//  GeoLocator.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import CoreLocation
import UIKit

class GeoLocator: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // TODO: remove
        print("update: ", locations)
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: remove
        print("error:", error.localizedDescription, error.localizedDescription.debugDescription)
        if (error._code == CLError.denied.rawValue) {
            let alert = UIAlertController(title: "Permission needed", message: "Allow when in use location service please", preferredStyle: .alert)
            let action = UIAlertAction(title: "Settings", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.openURL(url)
                }
            }
            alert.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
