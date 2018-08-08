//
//  EditProfileVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 06.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    var mainText = String()
    var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var editProfileProtocol:EditProfileProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.textField.text = mainText
        
        self.view.addSubview(textField)
        textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: TOP_CONSTANT).isActive = true
        textField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        textField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Do any additional setup after loading the view.
        let button_1 = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.saveAction))
        self.navigationItem.rightBarButtonItem = button_1
    }
    
    
    @objc func saveAction(){
        if !(textField.text?.isEmpty)! {
            editProfileProtocol!.updateDisplayName(displayName: textField.text!)
            self.navigationController?.popViewController(animated: true)
        }
    }

}
