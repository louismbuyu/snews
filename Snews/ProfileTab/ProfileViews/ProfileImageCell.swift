//
//  ProfileImageCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 05.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class ProfileImageCell: UITableViewCell {
    
    var profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var editImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    var hasValue = Bool()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        let screenWidth = UIScreen.main.bounds.width
        profileImage.heightAnchor.constraint(equalToConstant: screenWidth).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        hasValue = false
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
