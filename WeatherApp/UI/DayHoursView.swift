//
//  DayHoursView.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/28/25.
//

import Foundation
import UIKit

class DayHoursView: UIView {
    let date = UILabel()
    let hours = HoursView()
    
    init() {
        super.init(frame: CGRect.zero)
        date.insert(in: self)
        date.center(x: 0)
        date.pin(top: 0)
        date.font = UIFont.systemFont(ofSize: 12)
        date.textColor = .white
        hours.insert(in: self)
        hours.pin(left: 0, right: 0)
        hours.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 1).isActive = true
        hours.pin(bottom: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
