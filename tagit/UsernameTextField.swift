//
//  UsernameTextField.swift
//  tagit
//
//  Created by Eamon White on 12/3/17.
//  Copyright © 2017 EamonWhite. All rights reserved.
//

import Foundation
import UIKit

class UsernameTextField : UITextField {
    
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 225, height:44))
        
        let colorWhiteAlpha = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        self.attributedPlaceholder = NSAttributedString(string: "enter a username", attributes: [NSAttributedStringKey.foregroundColor : colorWhiteAlpha])
        self.backgroundColor = UIColor(red: 200.0/255, green: 17.0/255, blue: 57.0/255, alpha: 0.6)
        self.font = UIFont(name: "Menlo-Regular", size: 18)
        self.textColor = UIColor.white
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.default
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextFieldViewMode.whileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        self.autocapitalizationType = .none
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.width/40
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 8, 0, 8)))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: UIEdgeInsetsInsetRect(bounds,  UIEdgeInsetsMake(0, 8, 0, 8)))
    }
}


