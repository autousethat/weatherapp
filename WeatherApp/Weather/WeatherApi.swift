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
            let kind = cond["text"] as? String,
            let forecast = json["forecast"] as? [String: Any],
            let forecastdays = forecast["forecastday"] as? [[String: Any]] {
            var dayHours = [WeatherDayHoursModel]()
            for day in forecastdays {
                if
                    let date = day["date_epoch"] as? Double,
                    let hour = day["hour"] as? [[String: Any]] {
                    var hours = [WeatherHourModel]()
                    for one in hour {
                        if
                            let time = one["time_epoch"] as? Double,
                            let temp = one["temp_c"] as? Double,
                            let cond = one["condition"] as? [String: Any],
                            let icon = cond["icon"] as? String {
                            hours.append(WeatherHourModel(time: time, icon: "http:" + icon, temp: temp))
                        }
                    }
                    dayHours.append(WeatherDayHoursModel(date: date, hours: hours))
                }
            }
            return WeatherModel(day: WeatherDayModel(temp: temp, feels: feels, wind: wind, icon: "http:" + icon, kind: kind, place: country + " / " + region + " / " + name, time: time), dayHours: dayHours)
        }
        return nil
    }
    
}
