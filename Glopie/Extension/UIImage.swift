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

extension UIImage {
    static func createInitialImage(from user: User, with size: CGSize) -> UIImage {
        let frame = CGRect(origin: .zero, size: size)
        //draw image first
        let image = UIImage()
        UIGraphicsBeginImageContext(size)
        image.draw(in: frame)

        //text attributes
        let font = UIFont(name: "Avenir", size: 32)!
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textColor: UIColor = .white
        let attributes=[NSAttributedStringKey.font: font, NSAttributedStringKey.paragraphStyle: textStyle, NSAttributedStringKey.foregroundColor: textColor]
        let initialFirst = user.firstname.uppercased().first ?? Character("")
        let initialSecond = user.lastname.uppercased().first ?? Character("")
        let text = String(initialFirst) + String(initialSecond)
        //vertically center (depending on font)
        let textHeight = font.lineHeight
        let textYPos = (image.size.height - textHeight)/2
        let textRect = CGRect(x: 0, y: textYPos, width: image.size.width, height: textHeight)
        text.draw(in: textRect.integral, withAttributes: attributes)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return result ?? image
    }
}
