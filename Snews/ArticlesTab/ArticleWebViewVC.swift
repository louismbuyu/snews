//
//  ArticleWebViewVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class ArticleWebViewVC: UIViewController {
    
    var article: Article?
    
    var webView: UIWebView = {
        let view = UIWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "unfilledstar"), for: .normal)
        button.tintColor = UIColor.gray
        button.addTarget(self, action: #selector(favoriteAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    /*let favoriteLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().normal(15)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightGray
        lbl.text = "0.000"
        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "unfilledheart"), for: .normal)
        button.tintColor = UIColor.gray
        button.addTarget(self, action: #selector(likeAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let likeLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().normal(15)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.lightGray
        lbl.text = "0.000"
        lbl.sizeToFit()
        return lbl
    }()*/
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = UIColor.gray
        button.addTarget(self, action: #selector(shareAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    var progressHUB = ProgressHUD(text: "Loading...")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(bottomView)
        bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        self.view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 0).isActive = true
        
        self.bottomView.addSubview(divider)
        divider.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 0).isActive = true
        divider.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        divider.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        /*self.bottomView.addSubview(favoriteButton)
        self.favoriteButton.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: TOP_CONSTANT).isActive = true
        self.favoriteButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        self.favoriteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.favoriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.bottomView.addSubview(favoriteLbl)
        self.favoriteLbl.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: TOP_CONSTANT).isActive = true
        self.favoriteLbl.leftAnchor.constraint(equalTo: favoriteButton.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.favoriteLbl.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.favoriteLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.bottomView.addSubview(likeButton)
        self.likeButton.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: TOP_CONSTANT).isActive = true
        self.likeButton.leftAnchor.constraint(equalTo: favoriteLbl.rightAnchor, constant: LEFT_CONSTANT).isActive = true
        self.likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.bottomView.addSubview(likeLbl)
        self.likeLbl.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: TOP_CONSTANT).isActive = true
        self.likeLbl.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.likeLbl.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.likeLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true*/
        
        self.bottomView.addSubview(shareButton)
        self.shareButton.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: TOP_CONSTANT).isActive = true
        self.shareButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: LEFT_CONSTANT*3).isActive = true
        self.shareButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.shareButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(progressHUB)
        let url = URL(string: (article?.url)!)
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            let task = session.dataTask(with: request){ (data,response,error) in
                if error == nil{
                    DispatchQueue.main.async {
                        self.progressHUB.removeFromSuperview()
                        self.webView.loadRequest(request)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.progressHUB.removeFromSuperview()
                        let errorAlertVC = CustomAlert()
                        errorAlertVC.modalPresentationStyle = .overFullScreen
                        errorAlertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                        errorAlertVC.actionCallback = { (view) in
                            view.dismiss(animated: true, completion: nil)
                        }
                        errorAlertVC.dialogTitle = NSLocalizedString("Oops", comment: "--")
                        errorAlertVC.dialogImage = UIImage(named: "error")
                        errorAlertVC.dialogMessage = NSLocalizedString("Looks like an error has occured, please try again later.", comment: "--")
                        self.present(errorAlertVC, animated: true, completion: nil)
                    }
                }
            }
            task.resume()
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func favoriteAction(_ sender: UIButton){
        
    }
    
    @objc func likeAction(_ sender: UIButton){
        
    }
    
    @objc func shareAction(_ sender: UIButton){
        let nextVC = SearchUsersTVC()
        nextVC.article = self.article
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
