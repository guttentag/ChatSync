//
//  ConversationController.swift
//  ChatSync
//
//  Created by Eran Guttentag on 23/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import Foundation

protocol ConversationController {
    func send(_ message: Message)
    func fetch(_ from: TimeInterval, to: TimeInterval)
    func fetch(_ lastN: Int)
    var allMessages: [[Message]] { get }
}

protocol ConversationDelegate {
    func conversation(_ allMessages: [[Message]])
}
