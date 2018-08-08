//
//  ChatCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    var messageView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BLUE
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    var messageText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = FONTS().normal(16)
        label.numberOfLines = 0
        return label
    }()
    
    var timeStamp: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.textAlignment = .left
        label.font = FONTS().normal(12)
        return label
    }()
    
    var readImage: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "tick"), for: .normal)
        button.tintColor = UIColor.gray
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.main.bounds.width
        let messageWidth = (screenWidth/4)*3
        
        addSubview(messageView)
        messageView.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT).isActive = true
        messageView.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        messageView.widthAnchor.constraint(lessThanOrEqualToConstant: messageWidth).isActive = true
        messageView.heightAnchor.constraint(lessThanOrEqualToConstant: 500).isActive = true
        
        self.messageView.addSubview(messageText)
        messageText.topAnchor.constraint(equalTo: self.messageView.topAnchor, constant: TOP_CONSTANT).isActive = true
        messageText.rightAnchor.constraint(equalTo: self.messageView.rightAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        messageText.leftAnchor.constraint(equalTo: self.messageView.leftAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        messageText.bottomAnchor.constraint(equalTo: self.messageView.bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        
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

}
