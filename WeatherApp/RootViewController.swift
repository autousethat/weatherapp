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
    
    let currentView = CurrentWeatherView()
    let hourlyView = HourlyWeatherView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentView.insert(in: view)
        currentView.pin(left: 0, right: 0)
        currentView.center(x: 0, yRatio: 0.2)
        currentView.place.text = "waiting location"
        
        hourlyView.showsVerticalScrollIndicator = false
        hourlyView.showsHorizontalScrollIndicator = false
        hourlyView.insert(in: view)
        hourlyView.pin(left: 0, right: 0)
        hourlyView.topAnchor.constraint(equalTo: currentView.bottomAnchor, constant: 4).isActive = true
        
        setLocator()
    }
    
    func setLocator() {
        locator.onUpdate = { [weak self] location in
            guard let self = self else {
                return
            }
            // TODO: background fetch
            if let weather = self.api.getCurrentWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude, days: 3) {
                print(weather)
                ImageLoader.from(weather.day.icon) { [weak view = self.currentView] image in
                    view?.icon.image = image
                }
                self.currentView.degree.text = String(format: "%.1f℃", weather.day.temp)
                self.currentView.place.text = weather.day.place
                let formatter = DateFormatter()
                formatter.dateFormat = "cccc d MMMM yyyy"
                self.currentView.date.text = formatter.string(from: Date(timeIntervalSince1970: weather.day.time))
                if let hours = weather.dayHours.first?.hours {
                    self.hourlyView.configure(hours)
                }
            }
            else {
                print("fetch error")
            }
                
            
            self.locator.stop()
        }
        locator.start()
        
        //api.request(.forecast(lat: 55, lon: 37, days: 3))
        // TODO: we just need forecast cause it have current in reply
        //    http://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=55.0,37.0&days=3
        //    Optional({
        //        current =     {
        //            cloud = 25;
        //            condition =
    }
    
}

