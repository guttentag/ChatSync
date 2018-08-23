//
//  ViewController.swift
//  ChatSync
//
//  Created by Eran Guttentag on 21/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var messagesTableView: UITableView!
    
    var messageController: MessagesController!
    var messagesDataSource = [[Message]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.messagesTableView.separatorStyle = .none
        self.messagesTableView.allowsSelection = false
        self.messagesTableView.dataSource = self
        
        self.messageController = MessagesController()
        self.messageController.startObserving(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private extension ViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
                return
        }
        
        DispatchQueue.main.async {
            let keyBoardRect = keyboardFrame.cgRectValue
            let currentInset = self.view.safeAreaInsets.bottom
            self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, keyBoardRect.height - currentInset, 0)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        DispatchQueue.main.async {
            let currentInset = self.view.safeAreaInsets.bottom
            self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            self.view.layoutIfNeeded()
        }

    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesDataSource[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.messagesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier, for: indexPath) as! MessageTableViewCell
        
        let item = self.messagesDataSource[indexPath.section][indexPath.row]
        cell.set(item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let message = self.messagesDataSource[section].first else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / yyyy"
        let date = Date(timeIntervalSince1970: message.timestamp)
        return dateFormatter.string(from: date)
    }
}

extension ViewController: ConversationDelegate {
    func conversation(_ allMessages: [[Message]]) {
        DispatchQueue.main.async {
            self.messagesDataSource = allMessages
            self.messagesTableView.reloadData()
            if let lastSectionSize = allMessages.last?.count, lastSectionSize > 0 {
                self.messagesTableView.scrollToRow(at: IndexPath(row: lastSectionSize - 1, section: allMessages.count - 1), at: .bottom, animated: true)
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let content = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !content.isEmpty {
            let now = Date().timeIntervalSince1970
            let newMessage = Message(now.description.replacingOccurrences(of: ".", with: "_"), timestamp: now, sender: "SENDER_ID_xxx", content: content)
            self.messageController.send(newMessage)
        }
        textField.endEditing(true)
        return true
    }
}
