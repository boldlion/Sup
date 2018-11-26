//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by Angela Yu on 30/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import ChameleonFramework

class CustomMessageCell: UITableViewCell {

    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    var message: Message? {
        didSet {
            updateView()
        }
    }

    func updateView() {
        guard let currentUser = Api.Auth.CURRENT_USER else { return }
        
        if currentUser.email == message?.sender {
            messageBackground.backgroundColor = UIColor.flatBlue()
            avatarImageView.backgroundColor = UIColor.flatBlue()
            senderUsername.textColor = UIColor.white
        }
        else {
            messageBackground.backgroundColor = UIColor.flatGray()
            avatarImageView.backgroundColor = UIColor.flatGray()
            senderUsername.textColor = UIColor.darkGray
        }
        
        if let msg = message {
            messageBody.text = msg.text
        }
        if let sender = message?.sender {
            senderUsername.text = sender
        }
        
        avatarImageView.image = UIImage(named: "egg")
        avatarImageView.contentMode = .scaleAspectFit
    }
    

}
