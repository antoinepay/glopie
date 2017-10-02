//
//  MainTabBarItem.swift
//  Glopie
//
//  Created by Luc on 30/09/2017.
//

import UIKit
import ESTabBarController_swift

class MainTabBarItem: ESTabBarItemContentView {

    private var circle: UIView
    
    override init(frame: CGRect) {
        self.circle = UIView(frame: frame)
        super.init(frame: frame)
        backgroundColor = .clear
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1.15, y: 1.15)
        circle.frame = CGRect(x: 0.0, y: 0.0, width: 45.0, height: 45.0)
        circle.layer.cornerRadius = circle.frame.size.width / 2.0
        circle.center = center
        circle.transform = CGAffineTransform(scaleX: 0, y: 0)
        addSubview(circle)
        circle.backgroundColor = UIColor(hexString: "3EE1BC")
       
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circle.center = center
        bringSubview(toFront: imageView)
        imageView.tintColor = .white
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.frame = frame
        backgroundGradient.colors = [UIColor(hexString: "F45C43").cgColor, UIColor(hexString: "EB3349").cgColor]
        layer.insertSublayer(backgroundGradient, at: 0)
    }
    
    override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = imageView.transform.scaledBy(x: 0.8, y: 0.8)
        imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1.15, y: 1.15)
        UIView.commitAnimations()
        completion?()
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.circle.alpha = 1.0
        circle.center = center
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.circle.transform = .identity
            })
        } else {
            self.circle.transform = .identity
        }
    }
    
    override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
        circle.center = center
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.circle.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: nil)
        }
    }
    
}
