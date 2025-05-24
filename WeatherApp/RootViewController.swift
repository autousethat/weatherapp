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

    override func viewDidLoad() {
        super.viewDidLoad()
        locator.onUpdate = { [weak self] location in
            guard let self = self else {
                return
            }
            let weather = self.api.getCurrentWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            print(weather)
            
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

