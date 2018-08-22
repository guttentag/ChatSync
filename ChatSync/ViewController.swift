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
        
        self.messageController = MessagesController(self)
        self.messageController.startObserving()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}

extension ViewController: MessagesDateDelegate {
    func messagesData(_ messages: [[Message]]) {
        DispatchQueue.main.async {
            self.messagesDataSource = messages
            self.messagesTableView.reloadData()
            if let lastSectionSize = messages.last?.count, lastSectionSize > 0 {
                self.messagesTableView.scrollToRow(at: IndexPath(row: lastSectionSize - 1, section: messages.count - 1), at: .bottom, animated: true)
            }
        }
//
//        DispatchQueue.main.async {
//            let offset = self.messagesTableView.contentSize.height - self.messagesTableView.frame.height
//            print("HEIGHT \(offset)")
//            if offset > 0 {
//                self.messagesTableView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
//            }
//        }
    }
}
