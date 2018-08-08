//
//  SearchUsersCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 07.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class SearchUsersCell: UITableViewCell {
    
    var profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    let mainLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    let subLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor.gray
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(profileImage)
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addSubview(mainLbl)
        mainLbl.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        mainLbl.leftAnchor.constraint(equalTo: self.profileImage.rightAnchor, constant: LEFT_CONSTANT/2).isActive = true
        mainLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        mainLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(subLbl)
        subLbl.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        subLbl.leftAnchor.constraint(equalTo: self.profileImage.rightAnchor, constant: LEFT_CONSTANT/2).isActive = true
        subLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        subLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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
