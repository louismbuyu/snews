//
//  RecentChatsCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class RecentChatsCell: UITableViewCell {
    
    var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
        image.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        image.layer.borderWidth = 1
        image.clipsToBounds = true
        return image
    }()
    
    let usernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().medium(18)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.sizeToFit()
        return lbl
    }()
    
    let timeStampLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().normal(15)
        lbl.textAlignment = .right
        lbl.textColor = UIColor.lightGray
        lbl.sizeToFit()
        return lbl
    }()
    
    let lastMessageLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().normal(18)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.darkGray
        lbl.sizeToFit()
        return lbl
    }()
    
    var readProfileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        image.layer.borderWidth = 1
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: LEFT_CONSTANT).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(timeStampLbl)
        timeStampLbl.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT).isActive = true
        timeStampLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        timeStampLbl.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        timeStampLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(usernameLbl)
        usernameLbl.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT).isActive = true
        usernameLbl.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        usernameLbl.rightAnchor.constraint(equalTo: self.timeStampLbl.leftAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        usernameLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(readProfileImageView)
        readProfileImageView.topAnchor.constraint(equalTo: timeStampLbl.bottomAnchor, constant: 0).isActive = true
        readProfileImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        readProfileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        readProfileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(lastMessageLbl)
        lastMessageLbl.topAnchor.constraint(equalTo: usernameLbl.bottomAnchor, constant: 0).isActive = true
        lastMessageLbl.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        lastMessageLbl.rightAnchor.constraint(equalTo: self.readProfileImageView.leftAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        lastMessageLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lastMessageLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
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
