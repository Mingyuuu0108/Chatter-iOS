//
//  UIView.swift
//  chatter
//
//  Created by 이민규 on 2023/10/07.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
