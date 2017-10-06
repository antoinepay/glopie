//
//  MainTabBarController.swift
//  Glopie
//
//  Created by Luc on 30/09/2017.
//

import UIKit
import ESTabBarController_swift

class MainTabBarController: ESTabBarController {

    private let factory: Factory

    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup();
    }

    // MARK : Private
    
    private func setup() {
        if let tabBar = tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = ESTabBarItemPositioning.fillExcludeSeparator
        }
        
        let groupsNavigationController = GroupsNavigationController()
        let nav2 = UINavigationController()
        let accountNavigationController = AccountNavigationController()
        
        groupsNavigationController.viewControllers = [GroupsViewController(factory: factory)]
        nav2.viewControllers = [GroupTypeSelectionViewController(factory: factory)]
        accountNavigationController.viewControllers = [AccountViewController(factory: factory)]
        
        groupsNavigationController.tabBarItem = ESTabBarItem(
            MainTabBarItem(),
            title: nil,
            image: UIImage(named: "home"),
            selectedImage: UIImage(named: "home")
        )
        nav2.tabBarItem = ESTabBarItem(
            MainTabBarItem(),
            title: nil,
            image: UIImage(named: "add"),
            selectedImage: UIImage(named: "add")
        )
        accountNavigationController.tabBarItem = ESTabBarItem(
            MainTabBarItem(),
            title: nil,
            image: UIImage(named: "user"),
            selectedImage: UIImage(named: "user")
        )
        
        viewControllers = [groupsNavigationController, nav2, accountNavigationController]
    }

}
