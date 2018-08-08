//
//  ProfileItemCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 05.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class ProfileItemCell: UITableViewCell {
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().PROFILE_TITLE_FONT()
        lbl.textAlignment = .left
        lbl.textColor = PROFILE_TITLE_COLOR
        return lbl
    }()
    
    let valueLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().PROFILE_VALUE_FONT()
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.textColor = PROFILE_VALUE_COLOR
        return lbl
    }()
    
    var nextImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "next")
        return image
    }()
    
    var hasValue = Bool()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleLbl)
        titleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: TOP_CONSTANT).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: TITLE_HEIGHT).isActive = true
        
        self.addSubview(nextImage)
        nextImage.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        nextImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        nextImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        nextImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(valueLbl)
        valueLbl.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: TOP_CONSTANT).isActive = true
        valueLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        valueLbl.rightAnchor.constraint(equalTo: self.nextImage.leftAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        valueLbl.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        valueLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        
        self.hasValue = false
        nextImage.isHidden = true
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
