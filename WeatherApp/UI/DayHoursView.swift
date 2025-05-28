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
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
