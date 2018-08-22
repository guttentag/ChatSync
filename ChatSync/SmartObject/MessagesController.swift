//
//  MessagesController.swift
//  ChatSync
//
//  Created by Eran Guttentag on 22/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

class MessagesController {
    let messagesData: MessagesDataSet
    let firebaseWrapper: FirebaseWrapper
    
    init(_ delegate: MessagesDateDelegate) {
        self.messagesData = MessagesDataSet()
        self.messagesData.delegate = delegate
        self.firebaseWrapper = FirebaseWrapper.init()
    }
    
    func startObserving() {
        self.firebaseWrapper.set(self)
    }
}

extension MessagesController: FirebaseWrapperDelegate {
    func firebaseWrapper(_ message: Message) {
        self.messagesData.add(message)
    }
}
