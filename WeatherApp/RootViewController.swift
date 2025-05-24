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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentView.insert(in: view)
        currentView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.618).isActive = true
        currentView.aspect(1)
        currentView.center(x: 0, yRatio: 1 - 0.618)
        currentView.place.text = "waiting location"
        
        setLocator()
    }
    
    func setLocator() {
        locator.onUpdate = { [weak self] location in
            guard let self = self else {
                return
            }
            // TODO: background fetch
            if
                let weather = self.api.getCurrentWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude),
                let url = URL(string: weather.icon),
                let data = try? Data(contentsOf: url) {
                print(weather)
                let image = UIImage(data: data)
                self.currentView.icon.image = image
                self.currentView.degree.text = String(format: "%.1f℃", weather.temp)
                self.currentView.place.text = weather.place
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

