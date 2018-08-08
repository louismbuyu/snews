//
//  MainTabVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 03.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class MainTabVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab One
        let articlesTab = UINavigationController(rootViewController: ArticlesTVC())
        let articlesTabItem = UITabBarItem(title: "News", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        articlesTabItem.imageInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        articlesTab.tabBarItem = articlesTabItem
        
        // Create Tab Two
        let chatsTab = UINavigationController(rootViewController: RecentChatsTVC())
        let chatsTabItem = UITabBarItem(title: "Chats", image: UIImage(named: "chats"), selectedImage: UIImage(named: "chats"))
        chatsTabItem.imageInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        chatsTab.tabBarItem = chatsTabItem
        
        // Create Tab Two
        let profileTab = UINavigationController(rootViewController: ProfileTabTVC())
        let profileTabItem = UITabBarItem(title: "Profile", image: UIImage(named: "user_male"), selectedImage: UIImage(named: "user_male"))
        profileTabItem.imageInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        profileTab.tabBarItem = profileTabItem
        
        
        self.viewControllers = [articlesTab,chatsTab,profileTab]
    }
    
    // UITabBarControllerDelegate method
    @objc func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //print("Selected \(viewController.title)")
    }
}
