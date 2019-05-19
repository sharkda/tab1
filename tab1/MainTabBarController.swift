//
//  File.swift
//  tab1
//
//  Created by Jim Hsu on 2019/5/17.
//  Copyright © 2019 shark.com.tw. All rights reserved.
//

import UIKit

class MainTabBarController:UITabBarController{
    override func viewDidLoad() {
        tabBar.barTintColor = .frost
        view.backgroundColor = .black //doesn't matter since this will not show 
        setupTabBar()
    }
    
    func setupTabBar(){
    
        let firstController = UINavigationController(rootViewController: FirstViewController())
        firstController.tabBarItem.image = UIImage(named: "first")
        let secondController = UINavigationController(rootViewController: SecondViewController())
        secondController.tabBarItem.image = UIImage(imageLiteralResourceName: "second")
        
        viewControllers = [firstController, secondController]
    }
}
