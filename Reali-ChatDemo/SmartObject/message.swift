//
//  message.swift
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
    
    init(_ _id: String, timestamp ts: TimeInterval, sender: String) {
        self.id = _id
        self.timestamp = ts
        self.senderId = sender
    }
}

extension Message: Comparable {
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }
}
