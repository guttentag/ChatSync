//
//  MessageTableViewCell.swift
//  Reali-ChatDemo
//
//  Created by Eran Guttentag on 21/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    static let identifier = "MessageCellIdentifier"
    
    @IBOutlet private weak var boxView: UIView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var senderLabel: UILabel!
    @IBOutlet private weak var timestampLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.boxView.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.set(Message("", timestamp: 0, sender: "", content: ""))
    }
    
    func set(_ message: Message) {
        self.contentLabel.text = message.content
        self.senderLabel.text = message.senderId
        self.timestampLabel.text = message.timestamp.description
    }

}
