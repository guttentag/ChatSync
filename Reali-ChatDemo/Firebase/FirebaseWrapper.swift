//
//  FirebaseWrapper.swift
//  Reali-ChatDemo
//
//  Created by Eran Guttentag on 22/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import FirebaseDatabase
import os

protocol FirebaseWrapperDelegate: class {
    func firebaseWrapper(_ message: Message)
}

class FirebaseWrapper {
    private let rootRef: DatabaseReference
    private var delegate: FirebaseWrapperDelegate?
    
    init() {
        self.rootRef = Database.database().reference()
    }
    
    func set(_ delegate: FirebaseWrapperDelegate) {
        self.delegate = delegate
        self.rootRef.observe(DataEventType.childAdded) { (snapshot) in
            guard let rawData = snapshot.value as? [String: Any], let message = Message(rawData) else {
                os_log("FIR add fail for: %{public}@", log: Logger.log(.firebase), type: .debug, snapshot.value.debugDescription)
                return
            }
            
            self.delegate?.firebaseWrapper(message)
        }
    }
}
