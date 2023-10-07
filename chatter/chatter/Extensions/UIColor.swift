//
//  UIColor.swift
//  chatter
//
//  Created by 이민규 on 2023/10/07.
//

import UIKit

extension UIColor {
    
    convenience init(hex: UInt32, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255.0
        let green = Double((hex >> 8) & 0xff) / 255.0
        let blue = Double((hex) & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: opacity)
    }
    
    enum Colors {
        
        case white
        
        var color: UIColor {
            
            switch self {
                
            case .white:
                return .init(hex: 0xF8F8F8)
            }
        }
    }

}

