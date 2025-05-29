//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import UIKit

class RootViewController: UIViewController {
    
    let locator = GeoLocator()
    let api = WeatherApi()
    
    let currentView = CurrentView()
    
    private func setState(_ text: String?) {
        currentView.place.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentView.insert(in: view)
        currentView.pin(left: 0, right: 0)
        currentView.center(x: 0, yRatio: 0.2)
        
        setState("location detection")
        setLocator()
    }
    
    func setLocator() {
        locator.onUpdate = { [weak self] location in
            guard let self = self else {
                return
            }
            self.setState("requesting the weather")
            
            DispatchQueue.global().async {
                if let weather = self.api.getCurrentWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude, days: 3) {
                    // this is thread safe
                    ImageLoader.from(weather.day.icon) { [weak view = self.currentView] image in
                        view?.icon.image = image
                    }
                    DispatchQueue.main.async {
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
                    print("fetch error")
                }
            }
            self.locator.stop()
        }
        locator.start()
    }
    
}

