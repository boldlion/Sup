//
//  Message.swift
//  Sup
//
//  Created by Bold Lion on 17/11/2018.
//  Copyright (c) 2018 Bold Lion. All rights reserved.


struct Message {
    
    var sender: String = ""
    var text: String = ""
    var key: String = ""
}

extension Message {
    
    static func transformSnapshotToMessage(dict: [String: Any], key: String) -> Message {
        var message = Message()
        message.key = key
        message.sender = dict["sender"] as! String
        message.text = dict["text"] as! String
        return message
    }
}
