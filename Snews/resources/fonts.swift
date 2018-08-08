//
//  fonts.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 03.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class FONTS {
    
    func normal(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica Neue", size: size)!
    }
    
    func medium(_ size: CGFloat) -> UIFont {
        let normalFont = UIFont(name: "Helvetica Neue", size: size)!
        let boldFont = UIFont(descriptor: normalFont.fontDescriptor.withSymbolicTraits(.classSymbolic)!, size: normalFont.pointSize)
        return boldFont
    }
    
    func bold(_ size: CGFloat) -> UIFont {
        let normalFont = UIFont(name: "Helvetica Neue", size: size)!
        let boldFont = UIFont(descriptor: normalFont.fontDescriptor.withSymbolicTraits(.traitBold)!, size: normalFont.pointSize)
        return boldFont
    }
    
    func PROFILE_TITLE_FONT() -> UIFont {
        return UIFont(name: "Helvetica Neue", size: 12)!
    }
    
    func PROFILE_VALUE_FONT() -> UIFont {
        return UIFont(name: "Helvetica Neue", size: 20)!
    }
}
