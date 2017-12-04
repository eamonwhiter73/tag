//
//  TagButton.swift
//  tagit
//
//  Created by Eamon White on 12/1/17.
//  Copyright © 2017 EamonWhite. All rights reserved.
//

import Foundation
import UIKit

class TagButton : UIButton {
    
    required init() {
        super.init(frame: CGRect(x:0, y:0, width:72, height:72))
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width/2
        self.backgroundColor = UIColor(red: 200.0/255, green: 17.0/255, blue: 57.0/255, alpha: 0.6)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
