//
//  GeoLocator.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import CoreLocation
import UIKit

class GeoLocator: NSObject, CLLocationManagerDelegate {
    
    private var isUpdating = false
    
    var onUpdate: (CLLocation) -> Void = { _ in }
    
    let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        isUpdating = true
        manager.startUpdatingLocation()
        if let location = manager.location {
            onUpdate(location)
        }
    }
    
    func stop() {
        isUpdating = false
        manager.stopUpdatingLocation()
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard isUpdating else {
            return
        }
        if let location = locations.first {
            onUpdate(location)
        }
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error._code == CLError.denied.rawValue) {
            let alert = UIAlertController(title: "Permission denied", message: "Allow location services please", preferredStyle: .alert)
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
