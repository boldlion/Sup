//
//  RegisterViewController.swift
//  Sup
//
//  Created by Bold Lion on 17/11/2018.
//  Copyright (c) 2018 Bold Lion. All rights reserved.

import UIKit
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
  
    @IBAction func registerPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        
        guard let email = emailTextfield.text, email != "" else { return }
        guard let password = passwordTextfield.text, password != "" else { return }

        Api.Auth.registerUser(with: email, password: password, onError: { error in
            SVProgressHUD.showError(withStatus: error)
        }, onSuccess: { [unowned self] in
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "goToChat", sender: nil)
        })
    }
}
