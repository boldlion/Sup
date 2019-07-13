//
//  ChatViewController.swift
//  Sup
//
//  Created by Bold Lion on 17/11/2018.
//  Copyright (c) 2018 Bold Lion. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChatViewController: UIViewController {
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.isEnabled = false
        configureTableView()
        setKeyboardNotifications()
        handleTextFields()
        addTapGesture()
        fetchMessages()
        navigationItem.hidesBackButton = true
    }
    
    func fetchMessages() {
        Api.Message.getMessages(onSuccess: { [unowned self] message in
            self.messages.append(message)
            self.messageTableView.reloadData()
        }, onError: { error in
            SVProgressHUD.showError(withStatus: error)
        })
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        sendButton.isEnabled = false
        messageTextfield.isEnabled = false
        
        guard let text = messageTextfield.text, text != "" else { return }
        
        Api.Message.sendMessage(text: text, onError: { error in
            SVProgressHUD.showError(withStatus: error)
        }, onSuccess: { [unowned self] in
            self.sendButton.isEnabled = true
            self.messageTextfield.isEnabled = true
            self.messageTextfield.text = ""
        })
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        Api.Auth.logout(onError: { errorMessage in
            SVProgressHUD.showError(withStatus: errorMessage)
        }, onSuccess: { [unowned self] in
             guard self.navigationController?.popToRootViewController(animated: true) != nil else { return }
        })
    }
    
    private func setKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.heightConstraint.constant = keyboardFrame!.height + 50
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.heightConstraint.constant = 50
            self.view.endEditing(true)
            self.view.layoutIfNeeded()
        }
    }
    
    func handleTextFields() {
        messageTextfield.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        if let text = messageTextfield.text, !text.isEmpty {
            sendButton.setTitleColor(UIColor.green, for: .normal)
            sendButton.isEnabled = true
            return
        }
        sendButton.isEnabled = false
        sendButton.setTitleColor(.lightGray, for: .normal)
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide(_:)))
        messageTableView.isUserInteractionEnabled = true
        messageTableView.addGestureRecognizer(tap)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 81
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "customMessageCell") as! CustomMessageCell
        cell.message = messages[indexPath.row]
        return cell
    }
    
    
}
