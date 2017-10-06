//
//  SharedViewController.swift
//  Glopie
//
//  Created by Antoine Payan on 05/10/2017.
//

import UIKit
import Lottie

class SharedViewController: UIViewController {

    var factory: Factory
    var placeholderView: UIView?
    var dismissKeyboardTap = UITapGestureRecognizer()
    init(factory: Factory, nibName: String) {
        self.factory = factory
        super.init(nibName: nibName, bundle: nil)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
    }

    func updateNavigationTitleView(from scrollView: UIScrollView, with origin: CGPoint) {
        if origin.y - scrollView.contentOffset.y < 0 {
            navigationItem.titleView?.alpha = (origin.y - scrollView.contentOffset.y) * 0.05 + 1.0
        } else {
            navigationItem.titleView?.alpha = 1.0
        }
    }

    func setupNavigationTitleView(with text: String, fontSize: CGFloat = 20) {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Avenir", size: fontSize)
        titleLabel.text = text
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }

    func setPlaceholder(_ visible: Bool) {
        if let placeholderView = placeholderView, !visible {
            placeholderView.removeFromSuperview()
            self.placeholderView = nil
        } else {
            placeholderView?.removeFromSuperview()
            let placeholder = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 128, height: 128)))
            if let path = Bundle.main.path(forResource: "loading", ofType: "json") {
                if let jsonData = try? NSData(contentsOfFile: path, options: .alwaysMapped) {
                    if let jsonResult: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as? NSDictionary {
                        let animationView = LOTAnimationView(json: jsonResult as! [AnyHashable : Any])
                        animationView.frame = placeholder.frame
                        animationView.center = view.center
                        placeholder.addSubview(animationView)
                        animationView.loopAnimation = true
                        animationView.play()
                        placeholderView = placeholder
                        view.addSubview(placeholderView ?? UIView())
                    }
                }
            }
        }
    }

    func updateCustomBackButton() {
        let backButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(popToViewController(_:)))
        backButtonItem.tintColor = TargetSettings.mainColor
        navigationItem.leftBarButtonItem = backButtonItem

    }

    @objc private func popToViewController(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @objc private func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }

}
