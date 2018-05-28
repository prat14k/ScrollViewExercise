//
//  SigninViewController.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/27/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SVProgressHUD


class SigninViewController: UIViewController {

    @IBOutlet weak private var fbLoginButton: FBSDKLoginButton! {
        didSet {
            fbLoginButton.delegate = self
            fbLoginButton.readPermissions = ["email", "public_profile" , "user_photos"]
        }
    }

}


extension SigninViewController: FBSDKLoginButtonDelegate {
    
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        if error != nil {
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        } else {
            performSegue(withIdentifier: SegueIdentifiers.SignInVC2PhotoBrowserVC, sender: nil)
        }
    }
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        SVProgressHUD.showSuccess(withStatus: "Logged Out")
    }

}
