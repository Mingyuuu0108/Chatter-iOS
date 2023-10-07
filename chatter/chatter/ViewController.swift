//
//  ViewController.swift
//  chatter
//
//  Created by 이민규 on 2023/10/06.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    
    let text1 = UILabel().then {
        $0.text = "텍스트"
    }
    
    let text2 = UILabel().then {
        $0.text = "텍스트"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        self.view.addSubviews(text1, text2)
    }
}

