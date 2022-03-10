//
//  UITextField + Extension.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import Foundation
import UIKit

extension UITextField {
    
    public func addShadowWithRoundCorners() {
        self.borderStyle = .none
        //self.backgroundColor = .systemGray6
        
        self.layer.cornerRadius = self.layer.frame.size.height / 2
        
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.white.cgColor
        
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        
        //left text padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
