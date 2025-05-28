//
//  HoursView.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/27/25.
//

import Foundation
import UIKit

class HoursView: UIScrollView {
    init() {
        super.init(frame: CGRect.zero)
    }
    
    func configure(_ hourly: [WeatherHourModel]) {
        for view in subviews {
            view.removeFromSuperview()
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var last: UIView?
        for weather in hourly {
            let hour = HourView()
            let date = Date(timeIntervalSince1970: weather.time)
            let delta = -date.timeIntervalSinceNow
            if delta >= 0 && delta < 3600 {
                hour.setCurrent(true)
                scrollTo = hour
            }
            hour.time.text = formatter.string(from: date)
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
    }
    
    var scrollTo: UIView?
    // some scroll magic here
    override func layoutSubviews() {
        super.layoutSubviews()
        if let frame = scrollTo?.frame {
            scrollTo = nil
            let x = frame.origin.x + frame.size.width / 2 - self.frame.size.width / 2
            self.setContentOffset(CGPoint(x: x, y: 0), animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
