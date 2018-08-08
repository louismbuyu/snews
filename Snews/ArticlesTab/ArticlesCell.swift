//
//  ArticlesCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class ArticlesCell: UITableViewCell {
    
    let marginConstant:CGFloat = 10
    
    var mediaCompanyImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        image.layer.borderWidth = 1
        image.image = UIImage(named: "capetown")
        image.clipsToBounds = true
        return image
    }()
    
    var articleImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 5
        image.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        image.layer.borderWidth = 1
        image.image = UIImage(named: "capetown")
        image.clipsToBounds = true
        return image
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().medium(18)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.text = "BEST CAPE TOWN TIPS EVER!!!!ggg"
        //lbl.sizeToFit()
        lbl.numberOfLines = 3
        return lbl
    }()
    
    let subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().normal(18)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.darkGray
        lbl.text = "BEST CAPE TOWN TIPS EVER!!!!ggg"
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let mediaCompanyNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().bold(17)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        //lbl.sizeToFit()
        return lbl
    }()
    
    let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().normal(15)
        lbl.textAlignment = .right
        lbl.textColor = UIColor.lightGray
        lbl.text = "12 June 2018"
        lbl.sizeToFit()
        return lbl
    }()
    
    /*lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "unfilledstar"), for: .normal)
        button.tintColor = UIColor.gray
        button.addTarget(self, action: #selector(favoriteAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let favoriteLbl: UILabel = {
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
    
    //var likeActionProtocol: LikeActionProtocol?
    //var liked: Bool?
    //var favoriteActionProtocol: FavoriteActionProtocol?
    //var favorited : Bool?
    var shareActionProtocol: ShareActionProtocol?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(mediaCompanyImageView)
        mediaCompanyImageView.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT).isActive = true
        mediaCompanyImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: LEFT_CONSTANT).isActive = true
        mediaCompanyImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        mediaCompanyImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(mediaCompanyNameLbl)
        self.mediaCompanyNameLbl.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT).isActive = true
        self.mediaCompanyNameLbl.leftAnchor.constraint(equalTo: mediaCompanyImageView.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.mediaCompanyNameLbl.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        self.mediaCompanyNameLbl.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(dateLbl)
        self.dateLbl.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT).isActive = true
        self.dateLbl.leftAnchor.constraint(equalTo: mediaCompanyNameLbl.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.dateLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        self.dateLbl.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        self.dateLbl.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(titleLbl)
        self.titleLbl.topAnchor.constraint(equalTo: self.mediaCompanyNameLbl.bottomAnchor, constant: TOP_CONSTANT-4).isActive = true
        self.titleLbl.leftAnchor.constraint(equalTo: mediaCompanyImageView.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.titleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        self.titleLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        addSubview(subTitleLbl)
        self.subTitleLbl.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: TOP_CONSTANT-4).isActive = true
        self.subTitleLbl.leftAnchor.constraint(equalTo: mediaCompanyImageView.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.subTitleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        self.subTitleLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        addSubview(articleImageView)
        self.articleImageView.topAnchor.constraint(equalTo: self.subTitleLbl.bottomAnchor, constant: TOP_CONSTANT-4).isActive = true
        self.articleImageView.leftAnchor.constraint(equalTo: mediaCompanyImageView.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.articleImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        self.articleImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        /*addSubview(favoriteButton)
        self.favoriteButton.topAnchor.constraint(equalTo: self.articleImageView.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        self.favoriteButton.leftAnchor.constraint(equalTo: mediaCompanyImageView.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.favoriteButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
        self.favoriteButton.heightAnchor.constraint(equalToConstant: 26).isActive = true*/
        
        addSubview(shareButton)
        self.shareButton.topAnchor.constraint(equalTo: self.articleImageView.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        self.shareButton.leftAnchor.constraint(equalTo: mediaCompanyImageView.rightAnchor, constant: LEFT_CONSTANT*2).isActive = true
        self.shareButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
        self.shareButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
        self.shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        
        /*addSubview(likeButton)
        self.likeButton.topAnchor.constraint(equalTo: self.articleImageView.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        self.likeButton.leftAnchor.constraint(equalTo: favoriteLbl.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.likeButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
        self.likeButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
        self.likeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        
        addSubview(likeLbl)
        self.likeLbl.topAnchor.constraint(equalTo: self.articleImageView.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        self.likeLbl.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        self.likeLbl.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.likeLbl.heightAnchor.constraint(equalToConstant: 26).isActive = true*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /*@objc func favoriteAction(_ sender: UIButton){
        favoriteActionProtocol?.favoriteAction(artcilesCell: self)
    }
    
    @objc func likeAction(_ sender: UIButton){
        likeActionProtocol?.likeAction(artcilesCell: self)
    }*/
    
    @objc func shareAction(_ sender: UIButton){
        shareActionProtocol?.shareAction(articlesCell: self)
    }
}
