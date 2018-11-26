//
//  MessageApi.swift
//  Sup
//
//  Created by Bold Lion on 22.11.18.
//  Copyright © 2018 Bold Lion. All rights reserved.
//

import Foundation
import Firebase

class MessageApi {
    
    let REF_MESSAGE = Database.database().reference().child("message")
    
    func sendMessage(text: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let dict = [ "sender" : currentUser.email!,
                     "text"   : text ]
        REF_MESSAGE.childByAutoId().setValue(dict) { (error, _) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            else {
                onSuccess()
            }
        }
    }
    
    func getMessages(onSuccess: @escaping (Message) -> Void, onError: @escaping (String) -> Void) {
        REF_MESSAGE.observe(.childAdded, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let message = Message.transformSnapshotToMessage(dict: dict, key: snapshot.key)
                onSuccess(message)
            }
        }, withCancel: { error in
            onError(error.localizedDescription)
            return
        })
    }
    
}
