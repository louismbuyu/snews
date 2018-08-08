//
//  ChatArticleCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 07.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class ChatArticleCell: UITableViewCell {
    
    lazy var messageView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectArticle))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    lazy var providerImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    lazy var providerName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.font = FONTS().normal(14)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var articleTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = FONTS().normal(16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var articleImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var timeStamp: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.textAlignment = .left
        label.font = FONTS().normal(12)
        return label
    }()
    
    lazy var readImage: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "tick"), for: .normal)
        button.tintColor = UIColor.gray
        return button
    }()
    
    var articleProtocol: ArticleProtocol?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.main.bounds.width
        let messageWidth = (screenWidth/4)*3
        
        addSubview(messageView)
        messageView.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT).isActive = true
        messageView.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        messageView.widthAnchor.constraint(lessThanOrEqualToConstant: messageWidth).isActive = true
        messageView.heightAnchor.constraint(lessThanOrEqualToConstant: 800).isActive = true
        
        self.messageView.addSubview(providerImage)
        providerImage.topAnchor.constraint(equalTo: self.messageView.topAnchor, constant: TOP_CONSTANT).isActive = true
        providerImage.leftAnchor.constraint(equalTo: self.messageView.leftAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        providerImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        providerImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.messageView.addSubview(providerName)
        providerName.topAnchor.constraint(equalTo: self.messageView.topAnchor, constant: TOP_CONSTANT).isActive = true
        providerName.leftAnchor.constraint(equalTo: self.providerImage.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        providerName.rightAnchor.constraint(equalTo: self.messageView.rightAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        providerName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.messageView.addSubview(articleTitle)
        articleTitle.topAnchor.constraint(equalTo: self.providerName.bottomAnchor, constant: TOP_CONSTANT/2).isActive = true
        articleTitle.leftAnchor.constraint(equalTo: self.messageView.leftAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        articleTitle.rightAnchor.constraint(equalTo: self.messageView.rightAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        articleTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        self.messageView.addSubview(articleImage)
        articleImage.topAnchor.constraint(equalTo: self.articleTitle.bottomAnchor, constant: TOP_CONSTANT/2).isActive = true
        articleImage.leftAnchor.constraint(equalTo: self.messageView.leftAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        articleImage.rightAnchor.constraint(equalTo: self.messageView.rightAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        articleImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        articleImage.bottomAnchor.constraint(equalTo: self.messageView.bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        
        addSubview(readImage)
        readImage.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 3).isActive = true
        readImage.heightAnchor.constraint(equalToConstant: 18).isActive = true
        readImage.widthAnchor.constraint(equalToConstant: 18).isActive = true
        readImage.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        
        addSubview(timeStamp)
        timeStamp.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 0).isActive = true
        timeStamp.heightAnchor.constraint(equalToConstant: 24).isActive = true
        timeStamp.rightAnchor.constraint(equalTo: self.readImage.leftAnchor, constant: RIGHT_CONSTANT_IN+4).isActive = true
        timeStamp.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        timeStamp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
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
    
    @objc func selectArticle(){
        articleProtocol?.viewArticle(index: messageView.tag)
    }
    
}
