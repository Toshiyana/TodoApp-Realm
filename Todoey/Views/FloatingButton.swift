//
//  FloatingButton.swift
//  Todoey
//
//  Created by Toshiyana on 2021/04/01.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import ChameleonFramework

class FloatingButton: NSObject {
    
    var floatButton: UIButton!
    private var parentView: UIView!

    private let trailingPadding: CGFloat = 15.0
    private let bottomPadding: CGFloat = -15.0
    private let buttonHeight: CGFloat = 50.0
    private let buttonWidth: CGFloat = 50.0
    
    init(attachedToView view: UIView) {
        super.init()
        
        parentView = view
        
        floatButton = UIButton(type: .custom)
        floatButton.layer.backgroundColor = CGColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        floatButton.layer.cornerRadius = buttonWidth / 2
        floatButton.layer.shadowOpacity = 0.25
        floatButton.layer.shadowRadius = 5
        floatButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        floatButton.setImage(UIImage(named: "icons8-plus"), for: .normal)
        floatButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        floatButton.translatesAutoresizingMaskIntoConstraints = false
        
        floatButton.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        parentView.addSubview(floatButton)
        
        installConstraints()
        
    }
        
    @objc func buttonTouchDown(_ sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.1,
                       options: UIView.AnimationOptions.allowAnimatedContent,
                       animations: {
                        sender.transform = CGAffineTransform.identity
                       },
                       completion: nil)
    }
    
    private func installConstraints() {
        
        let views: [String: UIView] = ["floatButton":floatButton, "parentView":parentView]
        let width = NSLayoutConstraint.constraints(withVisualFormat: "H:[floatButton(\(buttonWidth))]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        let height = NSLayoutConstraint.constraints(withVisualFormat: "V:[floatButton(\(buttonHeight))]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        floatButton.addConstraints(width)
        floatButton.addConstraints(height)
        
        //safeAreaLayoutGuide issue
        if #available(iOS 11.0, *) {
            let guide = self.parentView.safeAreaLayoutGuide
            floatButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -(trailingPadding)).isActive = true
            floatButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: bottomPadding).isActive = true
        }
        else {
            let trailingSpacing = NSLayoutConstraint.constraints(withVisualFormat: "V:[floatButton]-\(trailingPadding)-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
            let bottomSpacing = NSLayoutConstraint.constraints(withVisualFormat: "H:[floatButton]-\(bottomPadding)-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
            parentView.addConstraints(trailingSpacing)
            parentView.addConstraints(bottomSpacing)
        }
    }
    
    
    
}
