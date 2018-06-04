//
//  SigninViewController.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/27/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit
import FacebookLogin
import SVProgressHUD


class SigninViewController: UIViewController {

}


extension SigninViewController {
    
    @IBAction func loginButtonClicked() {
        
        LoginManager().logIn(readPermissions: [.userPhotos], viewController: self) { [weak self] (loginResult) in
            switch loginResult {
            case .failed(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            case .cancelled:
                SVProgressHUD.showError(withStatus: "Login cancelled")
            case .success(_,let declinedPermissions,_):
                guard declinedPermissions.count == 0  else { return SVProgressHUD.showError(withStatus: "Permission not granted") }
                self?.performSegue(withIdentifier: SegueIdentifiers.photoBrowserVC, sender: nil)
            }
        }

    }
    
}
