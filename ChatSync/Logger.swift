//
//  Logger.swift
//  ChatSync
//
//  Created by Eran Guttentag on 22/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import Foundation
import os

enum LoggerActivity: String {
    case firebase = "firebase"
    case viewController = "view controller"
    case dataSet = "data set"
    case general = ""
}

struct Logger {
    static let subsystem = "com.reali.chat-demo"
    static func log(_ category: LoggerActivity = .general) -> OSLog {
        return OSLog(subsystem: Logger.subsystem, category: category.rawValue)
    }
}
