//
//  Message.swift
//  Reali-ChatDemo
//
//  Created by Eran Guttentag on 21/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import Foundation

class Message: NSObject {
    override var hashValue: Int {
        return self.id.hashValue
    }
    
    let id: String
    let timestamp: TimeInterval
    let senderId: String
    let content: String
    
    init(_ _id: String, timestamp ts: TimeInterval, sender: String, content text: String) {
        self.id = _id
        self.timestamp = ts
        self.senderId = sender
        self.content = text
    }
    
    convenience init?(_ dictionary: Dictionary<String,Any>) {
        guard let idString = dictionary["id"] as? String,
            let time = dictionary["timestamp"] as? TimeInterval,
            let sender = dictionary["sender"] as? String,
            let message = dictionary["content"] as? String
            else {
                return nil
        }
        
        self.init(idString, timestamp: time, sender: sender, content: message)
    }
}

extension Message: Comparable {
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }
}
