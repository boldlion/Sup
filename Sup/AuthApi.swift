//
//  AuthApi.swift
//  Sup
//
//  Created by Bold Lion on 20.11.18.
//  Copyright © 2018 Bold Lion. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthApi {
    
    func registerUser(with email: String, password: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            else {
                onSuccess()
            }
        }
    }
    
    func loginUser(with email: String, password: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            else {
                onSuccess()
            }
        }
    }
    
    
    func logout(onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            onSuccess()
        }
        catch let error {
            onError(error.localizedDescription)
            
        }
    }
    
    var CURRENT_USER: User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        else {
            return nil
        }
    }
}
