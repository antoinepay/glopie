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


extension UIImageView {

    func image(with user: User) -> UIImage? {
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .lightGray
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: frame.size.height / 2.0)
        let initialFirst = user.firstname.uppercased().first ?? Character("")
        let initialSecond = user.lastname.uppercased().first ?? Character("")
        let initials = String(initialFirst) + String(initialSecond)
        nameLabel.text = initials
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}
