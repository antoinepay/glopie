//
//  MainTabBarController.swift
//  Glopie
//
//  Created by Luc on 30/09/2017.
//

import UIKit
import ESTabBarController_swift

class MainTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK : Private
    
    private func setup() {
        if let tabBar = tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = ESTabBarItemPositioning.fillExcludeSeparator
        }
        
        let groupsNavigationController = GroupsNavigationController()
        let nav2 = UINavigationController()
        let accountNavigationController = AccountNavigationController()
        
        groupsNavigationController.viewControllers = [GroupsViewController()]
        nav2.viewControllers = [GroupsViewController()]
        accountNavigationController.viewControllers = [AccountViewController()]
        groupsNavigationController.tabBarItem = ESTabBarItem(MainTabBarItem(), title: nil, image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        nav2.tabBarItem = ESTabBarItem(MainTabBarItem(), title: nil, image: UIImage(named: "add"), selectedImage: UIImage(named: "add"))
        accountNavigationController.tabBarItem = ESTabBarItem(MainTabBarItem(), title: nil, image: UIImage(named: "user"), selectedImage: UIImage(named: "user"))
        
        viewControllers = [groupsNavigationController, nav2, accountNavigationController]
    }

}
