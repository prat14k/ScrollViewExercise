//
//  SigninViewController.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/27/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class SigninViewController: UIViewController {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton! {
        didSet {
            fbLoginButton.delegate = self
            fbLoginButton.readPermissions = ["email", "public_profile" , "user_photos"]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension SigninViewController: FBSDKLoginButtonDelegate {
    
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        if error != nil {
            print(error)
            return
        }
    }
    
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        print("Did Logout of FB")
    }

}
