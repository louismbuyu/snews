//
//  SettingsVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 06.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.layer.cornerRadius = 3
        button.setTitle(NSLocalizedString("Logout", comment: "--"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = FONTS().normal(16)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(logoutAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        self.view.addSubview(logoutButton)
        logoutButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: TOP_CONSTANT*8).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc func logoutAction(){
        let userInstance = AuthService.instance
        userInstance.loggedIn = false
        userInstance.userDisplayName = ""
        userInstance.username = ""
        userInstance.userId = ""
        //userInstance.userObject = nil
        //userInstance.userImageData = nil
        self.present(OnboardingVC(), animated: true, completion: nil)
    }

}
