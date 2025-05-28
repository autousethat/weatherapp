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
            return URL(string: urlString)!
        }
    }
    
    func requestJSON(_ method: Method) -> Any? {
        if let data = try? Data(contentsOf: method.url) {
            return try? JSONSerialization.jsonObject(with: data, options: [])
        }
        return nil
    }
    

    func getCurrentWeather(lat: Double, lon: Double, days: Int) -> WeatherModel? {
        if
            let json = requestJSON(.forecast(lat: lat, lon: lon, days: days)) as? [String: Any],
            let loc = json["location"] as? [String: Any],
            let time = loc["localtime_epoch"] as? Double,
            let country = loc["country"] as? String,
            let region = loc["region"] as? String,
            let name = loc["name"] as? String,
            let curr = json["current"] as? [String: Any],
            let temp = curr["temp_c"] as? Double,
            let feels = curr["feelslike_c"] as? Double,
            let wind = curr["wind_kph"] as? Double,
            let cond = curr["condition"] as? [String: Any],
            let icon = cond["icon"] as? String,
            let kind = cond["text"] as? String {
            return WeatherModel(day: WeatherDayModel(temp: temp, feels: feels, wind: wind, icon: "http:" + icon, kind: kind, place: country + " / " + region + " / " + name, time: time), dayHours: Array(repeating: WeatherHourModel(time: time, icon: "http:" + icon, temp: temp), count: 24))
        }
        return nil
    }
    
}
