//
//  ProfileTabHeaderCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 05.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class ProfileTabHeaderCell: UITableViewCell {
    
    var profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        //lbl.backgroundColor = UIColor.groupTableViewBackground
        lbl.textColor = UIColor.lightGray
        return lbl
    }()
    
    let profileNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textAlignment = .left
        //lbl.backgroundColor = UIColor.groupTableViewBackground
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(profileImage)
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.addSubview(profileNameLbl)
        profileNameLbl.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -4).isActive = true
        profileNameLbl.leftAnchor.constraint(equalTo: self.profileImage.rightAnchor, constant: LEFT_CONSTANT).isActive = true
        profileNameLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        profileNameLbl.heightAnchor.constraint(equalToConstant: 40)
        
        self.addSubview(titleLbl)
        titleLbl.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 4).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: self.profileImage.rightAnchor, constant: LEFT_CONSTANT).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 40)
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
