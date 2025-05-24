//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import Foundation

class WeatherApi {
    static let key = "fa8b3df74d4042b9aa7135114252304"
    static let urlBase = "http://api.weatherapi.com/v1/"
    
    enum Method {
        case current(lat: Double, lon: Double)
        case forecast(lat: Double, lon: Double, days: Int)
        
        var url: URL {
            var urlString = urlBase
            switch(self) {
            case .current(let lat, let lon):
                urlString += "current.json?key=\(key)&q=\(lat),\(lon)"
            case .forecast(let lat, let lon, let days):
                urlString += "forecast.json?key=\(key)&q=\(lat),\(lon)&days=\(days)"
            }
            print(urlString)
            return URL(string: urlString)!
        }
    }
    
    func request(_ method: Method) {
        if let data = try? Data(contentsOf: method.url) {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }
    }
}
