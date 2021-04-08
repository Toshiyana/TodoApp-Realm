//
//  FloatingButton.swift
//  Todoey
//
//  Created by Toshiyana on 2021/04/01.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import ChameleonFramework

final class FloatingButton: UIButton {

    static let trailingValue: CGFloat = 30.0
    static let leadingValue: CGFloat = 30.0
    static let buttonHeight: CGFloat = 90.0
    static let buttonWidth: CGFloat = 90.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = FlatOrange()
        layer.cornerRadius = FloatingButton.buttonWidth / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
        setImage(UIImage(named: "icons8-plus"), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

    


