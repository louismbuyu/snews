//
//  styles.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 03.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    func renderUIViewToImage(_ viewToBeRendered:UIView?) -> UIImage
    {
        //UIGraphicsBeginImageContext((viewToBeRendered?.bounds.size)!)
        UIGraphicsBeginImageContextWithOptions((viewToBeRendered?.bounds.size)!, false, 0.0)
        viewToBeRendered!.drawHierarchy(in: viewToBeRendered!.bounds, afterScreenUpdates: true)
        
        viewToBeRendered!.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        //UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage!
    }
    
}

class TabButtons {
    
    let controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func rightButtonImage(imageName: String, tempSelector: Selector){
        
        let button_profile: UIButton = UIButton(type: UIButtonType.custom)
        button_profile.setImage(UIImage(named: imageName), for: UIControlState.normal)
        button_profile.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        button_profile.addTarget(self.controller, action: tempSelector, for: UIControlEvents.touchUpInside)
        button_profile.frame = CGRect(x:0,y: 0,width: 25,height: 25)
        let barButton_2 = UIBarButtonItem(customView: button_profile)
        self.controller.navigationItem.rightBarButtonItem = barButton_2
    }
    
    func rightButtonText(buttonText: String, tempSelector: Selector)
    {
        let button_1 = UIBarButtonItem(title: buttonText, style: UIBarButtonItemStyle.plain, target: self.controller, action: tempSelector)
        self.controller.navigationItem.rightBarButtonItem = button_1
    }
    
    func leftButtonImage(imageName: String, tempSelector: Selector){
        
        let button_profile: UIButton = UIButton(type: UIButtonType.custom)
        button_profile.setImage(UIImage(named: imageName), for: UIControlState.normal)
        button_profile.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        button_profile.addTarget(self.controller, action: tempSelector, for: UIControlEvents.touchUpInside)
        button_profile.frame = CGRect(x:0,y: 0,width: 25,height: 25)
        let barButton_2 = UIBarButtonItem(customView: button_profile)
        self.controller.navigationItem.leftBarButtonItem = barButton_2
    }
    
    func leftButtonText(buttonText: String, tempSelector: Selector)
    {
        let button_1 = UIBarButtonItem(title: buttonText, style: UIBarButtonItemStyle.plain, target: self.controller, action: tempSelector)
        self.controller.navigationItem.leftBarButtonItem = button_1
    }
}
