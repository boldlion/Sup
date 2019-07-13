//
//  LogInViewController.swift
//  Sup
//
//  Created by Bold Lion on 17/11/2018.
//  Copyright (c) 2018 Bold Lion. All rights reserved.


import UIKit
import SVProgressHUD

class LogInViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        
        Api.Auth.loginUser(with: email, password: password, onError: { error in
            SVProgressHUD.showError(withStatus: error)
        }, onSuccess: { [unowned self] in
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "goToChat", sender: nil)
        })
    }
}  
