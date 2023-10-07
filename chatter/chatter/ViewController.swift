//
//  ViewController.swift
//  chatter
//
//  Created by 이민규 on 2023/10/06.
//

import UIKit

class ViewController: UIViewController {
    
    let text: UILabel = {
        let text = UILabel()
        
        text.text = "텍스트"
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}

