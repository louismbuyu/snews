//
//  LoginVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 03.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
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
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NSLocalizedString("Password", comment: "--")
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = GREEN
        button.layer.cornerRadius = 3
        button.setTitle(NSLocalizedString("LogIn", comment: "--"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(signAction), for: UIControlEvents.touchUpInside)
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
    
    let signupTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.text = NSLocalizedString("LogInTitle", comment: "--")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var progressHUB = ProgressHUD(text: NSLocalizedString("Logging in...", comment: "--"))
    
    func setupMainView(){
        self.view.backgroundColor = UIColor.white
        
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
        
        self.view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: TOP_CONSTANT*3).isActive = true
        loginButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    @objc func signAction(){
        let errorAlertVC = CustomAlert()
        errorAlertVC.modalPresentationStyle = .overFullScreen
        errorAlertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        errorAlertVC.actionCallback = { (view) in
            view.dismiss(animated: true, completion: nil)
        }
        errorAlertVC.dialogTitle = NSLocalizedString("Oops", comment: "--")
        errorAlertVC.dialogImage = UIImage(named: "error")
        guard let username = usernameTextField.text?.lowercased() , usernameTextField.text != "" else {
            errorAlertVC.dialogMessage = NSLocalizedString("Please enter a username", comment: "--")
            self.present(errorAlertVC, animated: true, completion: nil)
            return
        }
        guard let pass = passwordTextField.text , passwordTextField.text != "" else {
            errorAlertVC.dialogMessage = NSLocalizedString("Please enter a password", comment: "--")
            self.present(errorAlertVC, animated: true, completion: nil)
            return
        }
        
        self.view.addSubview(progressHUB)
        AuthService.instance.loginUser(username: username, password: pass) { (success, error, message) in
            self.progressHUB.removeFromSuperview()
            if success{
                self.present(MainTabVC(), animated: true, completion: nil)
            }else{
                errorAlertVC.dialogMessage = NSLocalizedString("Looks like an error has occured, please try again later.", comment: "--")
                self.present(errorAlertVC, animated: true, completion: nil)
            }
        }
    }
    
    @objc func closeAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func forgotPasswordAction(){
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        self.loginButton.isEnabled = true
        self.loginButton.alpha = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
