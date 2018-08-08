//
//  SignUpVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 03.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        // Do any additional setup after loading the view.
    }
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NSLocalizedString("Username", comment: "--")
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(SignUpVC.emailTextFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NSLocalizedString("Password", comment: "--")
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(SignUpVC.passwordTextFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        return tf
    }()
    
    let reenterPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NSLocalizedString("Re-enter Password", comment: "--")
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(SignUpVC.reenterPasswordTextFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        return tf
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = GREEN
        button.layer.cornerRadius = 3
        button.setTitle(NSLocalizedString("SignUp", comment: "--"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(registerAction), for: UIControlEvents.touchUpInside)
        button.isEnabled = false
        button.alpha = 0.3
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "exit"), for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let tintLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = UIColor.white
        label.alpha = 1
        return label
    }()
    
    let policyLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.text = NSLocalizedString("SignUpPolicy", comment: "--")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let signupTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.text = NSLocalizedString("Sign up with your username", comment: "--")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let profileView: UIView = {
        let image = UIView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        image.layer.masksToBounds = true
        return image
    }()
    
    let profileNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 130)
        lbl.backgroundColor = UIColor.clear
        lbl.text = "W"
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        return lbl
    }()
    
    func setupMainView(){
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(profileView)
        
        profileView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        profileView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        profileView.addSubview(profileNameLbl)
        profileNameLbl.widthAnchor.constraint(equalToConstant: 180).isActive = true
        profileNameLbl.heightAnchor.constraint(equalToConstant: 180).isActive = true
        profileNameLbl.centerYAnchor.constraint(equalTo: self.profileView.centerYAnchor).isActive = true
        profileNameLbl.centerXAnchor.constraint(equalTo: self.profileView.centerXAnchor).isActive = true
        
        self.view.addSubview(tintLabel)
        tintLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tintLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tintLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tintLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.view.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: TOP_CONSTANT*2).isActive = true
        closeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.view.addSubview(signupTitleLabel)
        signupTitleLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        signupTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        signupTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        signupTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(usernameTextField)
        usernameTextField.topAnchor.constraint(equalTo: self.signupTitleLabel.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        usernameTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(reenterPasswordTextField)
        reenterPasswordTextField.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        reenterPasswordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        reenterPasswordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        reenterPasswordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: self.reenterPasswordTextField.bottomAnchor, constant: TOP_CONSTANT*3).isActive = true
        registerButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        registerButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.view.addSubview(policyLabel)
        policyLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        policyLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        policyLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: BOTTOM_CONSTANT*3).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func closeAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func signinAction(){
        self.present(LoginVC(), animated: true, completion: nil)
    }
    
    @objc func registerAction(){
        guard let username = usernameTextField.text , usernameTextField.text != "" else { print("Please enter an username"); return }
        guard let pass = passwordTextField.text , passwordTextField.text != "" else { print("Please enter a password"); return }
        
        let lowercaseStr = usernameTextField.text?.lowercased()
        let firstChar = lowercaseStr?.first
        profileNameLbl.text = "\(firstChar!)".uppercased()
        let lightRed = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
        let lightOrange = UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1.0)
        let lightNormGreen = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        let lightBlue = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        let lightPurple = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0)
        
        if firstChar! <= "e" {
            self.profileView.backgroundColor = lightRed
        }else if firstChar! >= "f" && firstChar! <= "j" {
            self.profileView.backgroundColor = lightOrange
        }else if firstChar! >= "k" && firstChar! <= "p" {
            self.profileView.backgroundColor = lightNormGreen
        }else if firstChar! >= "q" && firstChar! <= "u" {
            self.profileView.backgroundColor = lightBlue
        }else if firstChar! >= "u" && firstChar! <= "z" {
            self.profileView.backgroundColor = lightPurple
        }else{
            self.profileView.backgroundColor = lightPurple
        }
        
        let profileImage = UIImage().renderUIViewToImage(self.profileView)
        AuthService.instance.registerUser(username: username, password: pass, image: profileImage) { (success, error, message) in
            if success {
                self.present(MainTabVC(), animated: true, completion: nil)
            }else{
                //print("OOPS: \(error)")
                print("OOPS: ")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField){
        if !(textField.text?.isEmpty)!{
            if !(passwordTextField.text?.isEmpty)! && !(reenterPasswordTextField.text?.isEmpty)!{
                if (passwordTextField.text!.count > 1) && (reenterPasswordTextField.text!.count > 1){
                    if (passwordTextField.text == self.reenterPasswordTextField.text){
                        self.registerButton.isEnabled = true
                        self.registerButton.alpha = 1
                    }else{
                        self.registerButton.isEnabled = false
                        self.registerButton.alpha = 0.3
                    }
                }else{
                    self.registerButton.isEnabled = false
                    self.registerButton.alpha = 0.3
                }
            }else{
                self.registerButton.isEnabled = false
                self.registerButton.alpha = 0.3
            }
        }else{
            self.registerButton.isEnabled = false
            self.registerButton.alpha = 0.3
        }
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField){
        if !(textField.text?.isEmpty)!{
            if (textField.text!.count > 1){
                if !(self.reenterPasswordTextField.text?.isEmpty)! && !(self.usernameTextField.text?.isEmpty)! {
                    if (textField.text == self.reenterPasswordTextField.text){
                        self.registerButton.isEnabled = true
                        self.registerButton.alpha = 1
                    }else{
                        self.registerButton.isEnabled = false
                        self.registerButton.alpha = 0.3
                    }
                }else{
                    self.registerButton.isEnabled = false
                    self.registerButton.alpha = 0.3
                }
            }else{
                self.registerButton.isEnabled = false
                self.registerButton.alpha = 0.3
            }
        }else{
            self.registerButton.isEnabled = false
            self.registerButton.alpha = 0.3
        }
    }
    
    @objc func reenterPasswordTextFieldDidChange(_ textField: UITextField){
        if !(textField.text?.isEmpty)!{
            if (textField.text!.count > 1){
                if !(self.passwordTextField.text?.isEmpty)! && !(self.usernameTextField.text?.isEmpty)! {
                    if (textField.text == self.passwordTextField.text) {
                        self.registerButton.isEnabled = true
                        self.registerButton.alpha = 1
                    }else{
                        self.registerButton.isEnabled = false
                        self.registerButton.alpha = 0.3
                    }
                }else{
                    self.registerButton.isEnabled = false
                    self.registerButton.alpha = 0.3
                }
            }else{
                self.registerButton.isEnabled = false
                self.registerButton.alpha = 0.3
            }
        }else{
            self.registerButton.isEnabled = false
            self.registerButton.alpha = 0.3
        }
    }
    
    /*func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }*/
    
}
