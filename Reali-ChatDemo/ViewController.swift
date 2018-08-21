//
//  ViewController.swift
//  Reali-ChatDemo
//
//  Created by Eran Guttentag on 21/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var messagesTableView: UITableView!
    let messagesDataSet = MessagesDataSet()
    var messagesDataSource = [[Message]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.messagesTableView.separatorStyle = .none
        self.messagesTableView.allowsSelection = false
        self.messagesTableView.dataSource = self
        
        self.messagesDataSet.delegate = self
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
        }
    }
}
