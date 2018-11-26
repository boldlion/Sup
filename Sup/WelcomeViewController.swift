//
//  WelcomeViewController.swift
//  Sup
//
//  Created by Bold Lion on 17/11/2018.
//  Copyright (c) 2018 Bold Lion. All rights reserved.

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = Api.Auth.CURRENT_USER {
            performSegue(withIdentifier: "goToChat", sender: nil)
        }
    }
}
