//
//  UIImage.swift
//  Glopie
//
//  Created by Luc on 30/09/2017.
//

import Foundation
import UIKit

class GradientPoint: NSObject {
    var location: CGFloat
    var color: UIColor
    
    init(location: CGFloat, color: UIColor) {
        self.location = location
        self.color = color
    }
}

