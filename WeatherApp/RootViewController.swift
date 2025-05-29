//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    let locator = GeoLocator()
    let api = WeatherApi()
    
    let currentView = CurrentView()
    
    private var indicator: UIActivityIndicatorView?
    
    private func setState(_ text: String?) {
        indicator?.removeFromSuperview()
        if let text = text {
            currentView.place.text = text
            indicator = UIActivityIndicatorView()
            indicator!.insert(in: self.view)
            indicator!.center(x: 0)
            indicator!.topAnchor.constraint(equalTo: currentView.bottomAnchor, constant: 18).isActive = true
            indicator!.startAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentView.insert(in: view)
        currentView.pin(left: 0, right: 0)
        currentView.center(x: 0, yRatio: 0.2)
        
        setLocator()
    }
    
    func setLocator() {
        setState("detecting location")
        locator.onUpdate = { [weak self] location in
            guard let self = self else {
                return
            }
            self.weatherRequest(location: location)
            self.locator.stop()
        }
        locator.start()
    }
    
    func weatherRequest(location: CLLocation) {
        self.setState("requesting the weather")
        DispatchQueue.global().async {
            if let weather = self.api.getCurrentWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude, days: 3) {
                // this is thread safe
                ImageLoader.from(weather.day.icon) { [weak view = self.currentView] image in
                    view?.icon.image = image
                }
                DispatchQueue.main.async {
                    self.setState(nil)
                    self.currentView.degree.text = String(format: "%.1f℃", weather.day.temp)
                    self.currentView.place.text = weather.day.place
                    let formatter = DateFormatter()
                    formatter.dateFormat = "cccc d MMMM yyyy"
                    var anchor = self.currentView.bottomAnchor
                    for hours in weather.dayHours {
                        let dayHours = DayHoursView()
                        dayHours.insert(in: self.view)
                        dayHours.pin(left: 0, right: 0)
                        dayHours.topAnchor.constraint(equalTo: anchor, constant: 10).isActive = true
                        dayHours.date.text = formatter.string(from: Date(timeIntervalSince1970: hours.date))
                        dayHours.hours.configure(hours.hours)
                        anchor = dayHours.bottomAnchor
                    }
                }
            }
            else {
                // bg thread here
                Thread.sleep(forTimeInterval: 3)    // some spin for user
                DispatchQueue.main.async { [weak self] in
                    self?.setState(nil)
                    let alert = UIAlertController(title: "Fetch error", message: "Unknown internet connection or data error occuried", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Retry", style: .default) { _ in
                        self?.weatherRequest(location: location)
                    }
                    alert.addAction(action)
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}

