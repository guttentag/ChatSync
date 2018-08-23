//
//  MessagesController.swift
//  ChatSync
//
//  Created by Eran Guttentag on 22/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import Foundation

class MessagesController {
    private let messagesData: MessagesDataSet
    private let firebaseProvider: FirebaseProvider
    private var delegate: ConversationDelegate?
    
    init() {
        self.messagesData = MessagesDataSet()
        self.firebaseProvider = FirebaseProvider()
    }
    
    func startObserving(_ withDelegate: ConversationDelegate) {
        self.messagesData.delegate = self
        self.firebaseProvider.set(self)
        self.delegate = withDelegate
    }
    
    func stopObserving() {
        self.delegate = nil
        // TODO think through
    }
}

extension MessagesController: ConversationProviderDelegate {    
    func conversationProvider(_ message: Message) {
        self.messagesData.add(message)
    }
}

extension MessagesController: MessagesDateDelegate {
    func messagesData(_ messages: [[Message]]) {
        self.delegate?.conversation(messages)
    }
}

extension MessagesController: ConversationController {
    func fetch(_ from: TimeInterval, to: TimeInterval) {
        
    }
    
    func fetch(_ lastN: Int) {
        
    }
    
    func send(_ message: Message) {
        self.firebaseProvider.send(message)
    }
    
    var allMessages: [[Message]] {
        return []
    }
    
    
}
