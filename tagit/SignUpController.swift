//
//  SignUpController.swift
//  tagit
//
//  Created by Eamon White on 12/1/17.
//  Copyright © 2017 EamonWhite. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FirebaseAuth

class SignUpController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    let usernameTextField: UsernameTextField? = UsernameTextField()
    let passwordTextField: PasswordTextField? = PasswordTextField()
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith resultLogin: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription)
        } else if resultLogin.isCancelled {
            print("cancelled")
        } else if(self.usernameTextField == nil || self.passwordTextField == nil) {
            print("You need a username and password")
        } else {
            if((FBSDKAccessToken.current()) != nil) {
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil) {
                        print(result!)
                        
                        let credential = FacebookAuthProvider.credential(withAccessToken: resultLogin.token.tokenString)
                        Auth.auth().signIn(with: credential) { (user, error) in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }

                            //Save data in our database (UUID -> username)
                            print("user is signed in: " + Auth.auth().currentUser!.uid)
                            let uid = Auth.auth().currentUser!.uid
                            if let resultTemp = result as? [String:Any] {
                                guard let username = self.usernameTextField?.text else {
                                    print("No username to submit")
                                    return
                                }
                                
                                guard let password = self.passwordTextField?.text else {
                                    print("No password to submit")
                                    return
                                }
                                
                                let userDefaults = UserDefaults()
                                userDefaults.set(username, forKey: "username")
                                
                                let encryptionService = EncryptionService()
                                let encryptedPassword = encryptionService.AESEncryption(phrase: password, key: "fordecrypt", ivKey: "bonjour3bonjour3", encryptOrDecrypt: true)
                                userDefaults.set(encryptedPassword, forKey: "password") // ENCRYPTION
                                
                                guard let pw = encryptedPassword else {
                                    print("no password")
                                    return
                                }
                                
                                let pwNSDATA = pw as NSData
                                
                                let databaseService = DatabaseService()
                                databaseService.setUser(uid: uid, username: username, password: pwNSDATA.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters), email: resultTemp["email"] as! String, firstName: resultTemp["first_name"] as! String, lastName: resultTemp["last_name"] as! String)
                                
                                let viewController = ViewController()
                                UIApplication.shared.delegate?.window??.rootViewController = viewController
                            }
                            else {
                                print("error getting results")
                            }
                        }
                    }
                    else {
                        print(error?.localizedDescription ?? "error")
                    }
                })
            }
            else {
                print("no access token")
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("user logged out of facebook")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 200.0/255, green: 17.0/255, blue: 57.0/255, alpha: 0.6)
        
        let tag = UILabel(frame: CGRect(x: 0, y: 222, width: self.view.frame.width, height: 75))
        tag.attributedText = NSAttributedString(string: "tagit", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont(name: "Menlo-Regular", size: 65) ?? UIFont.systemFont(ofSize: 65)])
        view.addSubview(tag)
        tag.textAlignment = .center
        
        let viewWidth = self.view.frame.width
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.delegate = self
        loginButton.frame = CGRect(x: viewWidth/2 - 1/6 * viewWidth, y: self.view.frame.height/2 + 86, width: 1/3 * viewWidth, height: 30)
        view.addSubview(loginButton)
        
        self.usernameTextField?.delegate = self
        self.usernameTextField?.frame = CGRect(x: viewWidth/5, y: self.view.frame.height/2 - 22, width: viewWidth - 2/5 * viewWidth, height:44.0)
        view.addSubview(usernameTextField!)
        
        self.passwordTextField?.delegate = self
        self.passwordTextField?.frame = CGRect(x: viewWidth/5, y: self.view.frame.height/2 + 32, width: viewWidth - 2/5 * viewWidth, height:44.0)
        view.addSubview(self.passwordTextField!)
    }
    
    override func viewDidLayoutSubviews() {
        //
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

