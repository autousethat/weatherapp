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
        let weather = api.getCurrentWeather(lat: 55, lon: 37)
        print(weather, "\n\n==========")
        //api.request(.forecast(lat: 55, lon: 37, days: 3))
        // TODO: we just need forecast cause it have current in reply
//    http://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=55.0,37.0&days=3
//    Optional({
//        current =     {
//            cloud = 25;
//            condition =
    }
    
}

