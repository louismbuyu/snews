//
//  OnboardingCell.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 03.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class OnboardingCell: UICollectionViewCell {
    
    let marginConstant:CGFloat = 10
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    var image1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "tesla")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var image2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "goodn")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var image3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "news")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let headerText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().medium(40)
        lbl.textAlignment = .left
        lbl.textColor = .black
        return lbl
    }()
    
    let headerLine: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = BLUE
        return lbl
    }()
    
    let infoText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FONTS().medium(30)
        lbl.textAlignment = .left
        lbl.numberOfLines = 20
        lbl.textColor = UIColor.darkGray
        lbl.sizeToFit()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        addSubview(container)
        container.topAnchor.constraint(equalTo: topAnchor, constant: TOP_CONSTANT*8).isActive = true
        container.leftAnchor.constraint(equalTo: leftAnchor, constant: LEFT_CONSTANT).isActive = true
        container.rightAnchor.constraint(equalTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        container.heightAnchor.constraint(equalToConstant: 200).isActive = true
        // Do any additional setup after loading the view, typically from a nib.
        
        self.container.addSubview(image1)
        image1.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        image1.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0).isActive = true
        image1.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0).isActive = true
        image1.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        
        self.container.addSubview(image2)
        image2.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        image2.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0).isActive = true
        image2.bottomAnchor.constraint(equalTo: container.centerYAnchor, constant: 0).isActive = true
        image2.leftAnchor.constraint(equalTo: image1.rightAnchor, constant: 4).isActive = true
        
        self.container.addSubview(image3)
        image3.topAnchor.constraint(equalTo: image2.bottomAnchor, constant: 4).isActive = true
        image3.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0).isActive = true
        image3.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0).isActive = true
        image3.leftAnchor.constraint(equalTo: image1.rightAnchor, constant: 4).isActive = true
        
        addSubview(headerText)
        headerText.topAnchor.constraint(equalTo: container.bottomAnchor, constant: TOP_CONSTANT + 30).isActive = true
        headerText.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        headerText.leftAnchor.constraint(equalTo: leftAnchor, constant: LEFT_CONSTANT).isActive = true
        headerText.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: RIGHT_CONSTANT).isActive = true
        
        addSubview(headerLine)
        headerLine.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 0).isActive = true
        headerLine.leftAnchor.constraint(equalTo: leftAnchor, constant: LEFT_CONSTANT).isActive = true
        headerLine.heightAnchor.constraint(equalToConstant: 4).isActive = true
        headerLine.widthAnchor.constraint(equalTo: headerText.widthAnchor, multiplier: 0.7).isActive = true
        
        addSubview(infoText)
        infoText.topAnchor.constraint(equalTo: headerLine.bottomAnchor, constant: TOP_CONSTANT + marginConstant).isActive = true
        ///infoText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        infoText.leftAnchor.constraint(equalTo: leftAnchor, constant: LEFT_CONSTANT).isActive = true
        infoText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
