//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import UIKit

class CurrentWeatherView: UIView {
    
    let icon = UIImageView()
    let degree = UILabel()
    let place = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        icon.insert(in: self)
        icon.center(x: 0, yRatio: 0.33)
        icon.contentMode = .center
        degree.insert(in: self)
        degree.topAnchor.constraint(equalTo: icon.bottomAnchor).isActive = true
        degree.center(x: 0)
        degree.font = UIFont.systemFont(ofSize: 24)
        degree.textColor = .white
        place.insert(in: self)
        place.topAnchor.constraint(equalTo: degree.bottomAnchor).isActive = true
        place.center(x: 0)
        place.font = UIFont.systemFont(ofSize: 12)
        place.textColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
