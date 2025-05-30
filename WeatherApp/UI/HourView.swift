//
//  HourView.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/27/25.
//

import Foundation
import UIKit

class HourView: UIView {
    let time = UILabel()
    let icon = UIImageView()
    let temp = UILabel()
    
    func setCurrent(_ highlight: Bool) {
        backgroundColor = highlight ? UIColor(white: 1, alpha: 0.2) : .clear
    }
    
    init() {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 3
        layer.masksToBounds = true
        icon.insert(in: self)
        time.insert(in: self)
        temp.insert(in: self)
        
        time.pin(top: 0)
        time.center(x: 0)
        time.textColor = .lightGray
        time.font = UIFont.systemFont(ofSize: 10)
        
        icon.contentMode = .scaleAspectFit
        icon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        icon.pin(left: 8, right: 8)
        icon.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 0).isActive = true
        
        temp.textColor = .white
        temp.font = UIFont.systemFont(ofSize: 18)
        temp.center(x: 0)
        temp.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 0).isActive = true
        temp.pin(bottom: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
