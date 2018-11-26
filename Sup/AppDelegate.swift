//
//  AppDelegate.swift
//  Sup
//
//  Created by Bold Lion on 17/11/2018.
//  Copyright (c) 2018 Bold Lion. All rights reserved.

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}

