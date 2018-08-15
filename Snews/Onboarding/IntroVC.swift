//
//  IntroVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 03.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class IntroVC: UIViewController {
    
    let logoImage : UIImageView = {
        let image = UIImageView(image: UIImage(named: "snews"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let companyNameLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FONTS().medium(40)
        label.textAlignment = .center
        label.textColor = .black
        label.text = NSLocalizedString("SNEWS", comment: "--")
        return label
    }()
    
    let slogonLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FONTS().normal(18)
        label.textAlignment = .center
        label.textColor = BLUE
        label.text = NSLocalizedString("SnewsSlogan", comment: "--")
        return label
    }()
    
    let descriptionLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FONTS().normal(14)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.numberOfLines = 5
        label.text = NSLocalizedString("SnewsDescription", comment: "--")
        return label
    }()
    
    let signinButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = BLUE
        button.layer.cornerRadius = 3
        button.setTitle(NSLocalizedString("LogIn", comment: "--"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(signInAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.borderColor = BLUE.cgColor
        button.layer.cornerRadius = 3
        button.setTitle(NSLocalizedString("SignUp", comment: "--"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(BLUE, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(signUpAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    var type: UIViewContentMode = UIViewContentMode.scaleAspectFit
    var cornerRadius:CGFloat = 18
    var alpha:CGFloat = 1
    lazy var image1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "recode")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "vox")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "wired")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image4: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "techc")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image5: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "crunchbasenews")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image6: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "recode")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image7: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "crunchbasenews")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image8: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "theverge")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image9: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "techradar")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image10: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "thenextweb")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image11: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "recode")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var image12: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = type
        imageView.image = UIImage(named: "recode")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.alpha = alpha
        return imageView
    }()
    
    lazy var tabsStackView:UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.backgroundColor = UIColor.green
        s.distribution = .fillEqually
        s.alignment = .fill
        s.spacing = 5
        //s.autoresizingMask = [.flexibleWidth]
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addArrangedSubview(self.image1)
        s.addArrangedSubview(self.image2)
        s.addArrangedSubview(self.image3)
        s.addArrangedSubview(self.image4)
        //s.addArrangedSubview(self.image5)
        //s.addArrangedSubview(self.image6)
        return s
    }()
    
    lazy var tabsStackView2:UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.backgroundColor = UIColor.green
        s.distribution = .fillEqually
        s.alignment = .fill
        s.spacing = 5
        //s.autoresizingMask = [.flexibleWidth]
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addArrangedSubview(self.image7)
        s.addArrangedSubview(self.image8)
        s.addArrangedSubview(self.image9)
        s.addArrangedSubview(self.image10)
        //s.addArrangedSubview(self.image11)
        //s.addArrangedSubview(self.image12)
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.backgroundColor = UIColor.white
        let width = UIScreen.main.bounds.width/4
        self.view.addSubview(tabsStackView)
        tabsStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        tabsStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -16).isActive = true
        tabsStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 16).isActive = true
        tabsStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        self.view.addSubview(tabsStackView2)
        tabsStackView2.topAnchor.constraint(equalTo: self.tabsStackView.bottomAnchor, constant: 4).isActive = true
        tabsStackView2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -16).isActive = true
        tabsStackView2.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 16).isActive = true
        tabsStackView2.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        self.image1.heightAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        self.image2.heightAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        self.image3.heightAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        self.image4.heightAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        
        self.image7.heightAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        self.image8.heightAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        self.image9.heightAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        self.image10.heightAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        
        self.image1.bottomAnchor.constraint(equalTo: tabsStackView.bottomAnchor).isActive = true
        self.image2.bottomAnchor.constraint(equalTo: tabsStackView.bottomAnchor).isActive = true
        self.image3.bottomAnchor.constraint(equalTo: tabsStackView.bottomAnchor).isActive = true
        self.image4.bottomAnchor.constraint(equalTo: tabsStackView.bottomAnchor).isActive = true
        
        self.view.addSubview(companyNameLbl)
        companyNameLbl.topAnchor.constraint(equalTo: self.tabsStackView2.bottomAnchor, constant: TOP_CONSTANT*2).isActive = true
        companyNameLbl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        companyNameLbl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        companyNameLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(slogonLabel)
        slogonLabel.topAnchor.constraint(equalTo: self.companyNameLbl.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        slogonLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        slogonLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        slogonLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(descriptionLbl)
        descriptionLbl.topAnchor.constraint(equalTo: self.slogonLabel.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        //descriptionLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        descriptionLbl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        descriptionLbl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        descriptionLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(signupButton)
        signupButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(signinButton)
        signinButton.bottomAnchor.constraint(equalTo: self.signupButton.topAnchor, constant: BOTTOM_CONSTANT).isActive = true
        signinButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        signinButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        signinButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Do any additional setup after loading the view.
    }
    
    @objc func signInAction(){
        let nextVC = LoginVC()
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @objc func signUpAction(){
        let nextVC = SignUpVC()
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
