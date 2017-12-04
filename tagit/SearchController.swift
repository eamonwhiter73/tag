//
//  SearchController.swift
//  tagit
//
//  Created by Eamon White on 12/1/17.
//  Copyright © 2017 EamonWhite. All rights reserved.
//

import Foundation
import UIKit

class SearchController: UIViewController, UITextFieldDelegate {
    let tagTextfield = SearchTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        self.tagTextfield.delegate = self
        view.addSubview(tagTextfield)
    }
    
    override func viewDidLayoutSubviews() {
        self.tagTextfield.layer.cornerRadius = self.tagTextfield.frame.width/40
        self.tagTextfield.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:44.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
