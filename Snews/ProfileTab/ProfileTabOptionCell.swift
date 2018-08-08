//
//  ProfileTabOptionCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 05.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class ProfileTabOptionCell: UITableViewCell {
    
    var optionImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().normal(20)
        lbl.textAlignment = .left
        lbl.backgroundColor = UIColor.white
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(optionImage)
        optionImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        //optionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: TOP_CONSTANT).isActive = true
        optionImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: LEFT_CONSTANT).isActive = true
        optionImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        optionImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.addSubview(titleLbl)
        titleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        //titleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: TOP_CONSTANT).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: self.optionImage.rightAnchor, constant: LEFT_CONSTANT).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
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
