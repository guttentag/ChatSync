//
//  ConversationProvider.swift
//  ChatSync
//
//  Created by Eran Guttentag on 23/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import Foundation

protocol ConversationProviderDelegate {
    func conversationProvider(_ message: Message)
}

protocol ConversationProvider: ConversationController {}
