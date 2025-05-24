//
//  WeatherDayModel.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import Foundation

struct WeatherDayModel {
    // using C and km/h by default
    let temp: Double    // 27.1
    let feels: Double   // 23.8
    let wind: Double    // 14.4
    let icon: String    // http://x.com/sunny.png
    let kind: String    // sunny
    let place: String   // Russia/Moskva
}

extension WeatherApi {
    func getCurrentWeather(lat: Double, lon: Double) -> WeatherDayModel? {
        if
            let json = requestJSON(.current(lat: lat, lon: lon)) as? [String: Any],
            let loc = json["location"] as? [String: Any],
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
            return WeatherDayModel(temp: temp, feels: feels, wind: wind, icon: "http:" + icon, kind: kind, place: country + " / " + region + " / " + name)
        }
        return nil
    }
}
