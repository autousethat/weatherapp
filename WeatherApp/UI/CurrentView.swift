//
//  CurrentView.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import UIKit

class CurrentView: UIView {
    
    let icon = UIImageView()
    let degree = UILabel()
    let place = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        icon.insert(in: self)
        icon.pin(top: 0)
        icon.center(x: 0)
        icon.contentMode = .scaleAspectFit
        icon.widthAnchor.constraint(equalToConstant: 96).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 96).isActive = true
        degree.insert(in: self)
        degree.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: -20).isActive = true
        degree.center(x: 0)
        degree.font = UIFont.systemFont(ofSize: 24)
        degree.textColor = .white
        place.insert(in: self)
        place.topAnchor.constraint(equalTo: degree.bottomAnchor).isActive = true
        place.center(x: 0)
        place.font = UIFont.systemFont(ofSize: 12)
        place.textColor = .lightGray
        place.pin(bottom: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
