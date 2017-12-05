//
//  ManualTag.swift
//  tagit
//
//  Created by Eamon White on 12/1/17.
//  Copyright © 2017 EamonWhite. All rights reserved.
//

import Foundation
import UIKit

class ManualTagController: UIViewController, UITextFieldDelegate {
    let addTagButton = UIButton()
    let tagTextfield = UITextField()
    var addingTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.layer.cornerRadius = self.view.frame.width/80
        
        self.addTagButton.setAttributedTitle(NSAttributedString(string: "tag", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont(name: "Menlo-Regular", size: 52) ?? UIFont.systemFont(ofSize: 52)]), for: .normal)
        self.addTagButton.backgroundColor = UIColor(red: 200.0/255, green: 17.0/255, blue: 57.0/255, alpha: 0.8)
        self.addTagButton.addTarget(self, action: #selector(addTag), for: .touchUpInside)
        view.addSubview(addTagButton)
        
        let colorGray = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        self.tagTextfield.attributedPlaceholder = NSAttributedString(string: "#", attributes: [NSAttributedStringKey.foregroundColor : colorGray])
        self.tagTextfield.font = UIFont(name: "Menlo-Regular", size: 48)
        self.tagTextfield.borderStyle = UITextBorderStyle.roundedRect
        self.tagTextfield.autocorrectionType = UITextAutocorrectionType.no
        self.tagTextfield.keyboardType = UIKeyboardType.default
        self.tagTextfield.returnKeyType = UIReturnKeyType.done
        self.tagTextfield.clearButtonMode = UITextFieldViewMode.whileEditing;
        self.tagTextfield.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        self.tagTextfield.delegate = self
        self.tagTextfield.autocapitalizationType = .none
        view.addSubview(tagTextfield)
    }
    
    override func viewDidLayoutSubviews() {
        self.addTagButton.layer.cornerRadius = self.addTagButton.frame.width/80
        self.addTagButton.frame = CGRect(x: 5.0, y: 82, width: self.view.frame.width - 10.0, height:72.0)
        self.tagTextfield.frame = CGRect(x: 5.0, y: 5.0, width: self.view.frame.width - 10.0, height:72.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func addTag() {
        //Database service code here...
        print("in addTag .........")
        addingTag = 1
        
        if let myParent = self.parent as? ViewController {
            myParent.locationManager.startUpdatingLocation()
        }
        //This will go where service is done and it is successful
    }
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        print("in textFieldDidBeginEditing")
    }
    
    internal func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        print("in textFieldShouldEndEditing")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        print("in textFieldShouldReturn")
        return true
    }
}
