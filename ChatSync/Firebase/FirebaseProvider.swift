//
//  FirebaseProvider.swift
//  ChatSync
//
//  Created by Eran Guttentag on 22/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import FirebaseDatabase
import os

class FirebaseProvider: ConversationProvider {
    var allMessages: [[Message]] {
        return []
    }
    
    private let rootRef: DatabaseReference
    private var delegate: ConversationProviderDelegate?
    
    init() {
        self.rootRef = Database.database().reference()
    }
    
    func set(_ delegate: ConversationProviderDelegate) {
        self.delegate = delegate
        self.rootRef.observe(DataEventType.childAdded) { (snapshot) in
            guard let rawData = snapshot.value as? [String: Any], let message = Message(rawData) else {
                os_log("FIR add fail for: %{public}@", log: Logger.log(.firebase), type: .debug, snapshot.value.debugDescription)
                return
            }
            
            self.delegate?.conversationProvider(message)
        }
    }
    
    func send(_ message: Message) {
        self.rootRef.child(message.id).setValue(message.dictionary())
    }
    
    func fetch(_ from: TimeInterval, to: TimeInterval) {
        
    }
    
    func fetch(_ lastN: Int) {
        
    }
}
