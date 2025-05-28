//
//  HourlyWeatherView.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/27/25.
//

import Foundation
import UIKit

class HourlyWeatherView: UIScrollView {
    init() {
        super.init(frame: CGRect.zero)
    }
    
    func configure(_ hourly: [WeatherHourModel]) {
        for view in subviews {
            view.removeFromSuperview()
        }
        var last: UIView?
        for weather in hourly {
            let hour = HourView()
            hour.time.text = "00:00"
            ImageLoader.from(weather.icon) { [weak icon = hour.icon] image in
                icon?.image = image
            }
            let plus = weather.temp > 0 ? "+" : ""
            hour.temp.text = plus + String(format: "%.0f", weather.temp)
            hour.insert(in: self)
            hour.pin(top: 0, bottom: 0)
            if let last = last {
                hour.leftAnchor.constraint(equalTo: last.rightAnchor).isActive = true
            } else { // first element
                hour.pin(left: 0)
                heightAnchor.constraint(equalTo: hour.heightAnchor).isActive = true
            }
            last = hour
        }
        last?.pin(right: 0)
        print("subviews: ", subviews.count)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
