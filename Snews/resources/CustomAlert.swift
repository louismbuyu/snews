//
//  CustomAlert.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 14.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class CustomAlert: UIViewController {
    
    lazy var backgroundView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.alpha = 0.0
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        return view
    }()
    
    var dialogView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = FONTS().bold(20)
        return label
    }()
    
    var messageLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.font = FONTS().normal(16)
        label.numberOfLines = 0
        return label
    }()
    
    var seperatorView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    var okayBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(PRIMARY_COLOR, for: UIControlState.normal)
        button.backgroundColor = UIColor.white
        button.tintColor = UIColor.gray
        return button
    }()
    
    var centerLayout: NSLayoutConstraint?
    var startLayout: NSLayoutConstraint?
    var dialogTitle: String?
    var dialogMessage: String?
    var dialogImage: UIImage?
    var actionCallback: ( (_ view: CustomAlert) -> Void )?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.view.addSubview(self.dialogView)
        self.dialogView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: LEFT_CONSTANT*3).isActive = true
        self.dialogView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: RIGHT_CONSTANT*3).isActive = true
        self.dialogView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        startLayout = self.dialogView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        
        //animateView()
        
        dialogView.addSubview(imageView)
        imageView.image = dialogImage!
        imageView.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: TOP_CONSTANT*3).isActive = true
        imageView.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
        
        dialogView.addSubview(titleLabel)
        titleLabel.text = dialogTitle
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: TOP_CONSTANT*2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        dialogView.addSubview(messageLabel)
        messageLabel.text = dialogMessage!
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: TOP_CONSTANT*2).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: LEFT_CONSTANT_IN*2).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: RIGHT_CONSTANT_IN*2).isActive = true
        messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        dialogView.addSubview(seperatorView)
        seperatorView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: TOP_CONSTANT*2).isActive = true
        seperatorView.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 0).isActive = true
        seperatorView.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: 0).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        dialogView.addSubview(okayBtn)
        okayBtn.setTitle(NSLocalizedString("Okay", comment: "--"), for: UIControlState.normal)
        okayBtn.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        okayBtn.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 0).isActive = true
        okayBtn.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: 0).isActive = true
        okayBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        okayBtn.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        okayBtn.addTarget(self, action: #selector(actionButtonClicked), for: UIControlEvents.touchUpInside)
        centerLayout = self.dialogView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        centerLayout?.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateView()
    }
    
    func animateView(){
        UIView.animate(withDuration: 0.33, animations: {
            self.backgroundView.alpha = 0.2
        })
        
        centerLayout?.isActive = false
        startLayout?.isActive = true
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didTappedOnBackgroundView(){
        self.dismiss(animated: true)
    }
    
    @objc func actionButtonClicked(){
        actionCallback?(self)
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
