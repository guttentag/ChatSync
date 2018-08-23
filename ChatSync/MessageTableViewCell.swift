//
//  MessageTableViewCell.swift
//  ChatSync
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
    
    let dateFormatter = DateFormatter()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.dateFormatter.dateFormat = "hh:mm"
    }
    
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
        let date = Date(timeIntervalSince1970: message.timestamp)
        self.timestampLabel.text = self.dateFormatter.string(from: date)
    }

}
