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
    private var useMoscow = false   // special
    
    var onUpdate: (CLLocation) -> Void = { _ in }
    
    let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        guard !useMoscow else {
            onUpdate(CLLocation(latitude: 55.75361, longitude: 37.61972))
            return
        }
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
            let goAction = UIAlertAction(title: "Settings", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.openURL(url)
                }
            }
            let useAction = UIAlertAction(title: "Use Moscow", style: .destructive) { [weak self] _ in
                self?.stop()
                self?.useMoscow = true
                DispatchQueue.main.async {
                    self?.start()
                }
            }
            alert.addAction(goAction)
            alert.addAction(useAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
