//
//  ImageLoader.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/28/25.
//

import Foundation
import UIKit

class ImageLoader {
    static func from(_ urlString: String, _ callback: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if
                let url = URL(string: urlString),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    callback(image)
                }
            }
            else {
                // TODO: load retry
                callback(nil)
            }
        }
    }
}
