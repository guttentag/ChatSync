//
//  MessagesDataSet.swift
//  Reali-ChatDemo
//
//  Created by Eran Guttentag on 21/08/2018.
//  Copyright © 2018 Eran Guttentag. All rights reserved.
//

import Foundation
import os
protocol MessagesDateDelegate: class {
    func messagesData(_ messages: [[Message]])
}

class MessagesDataSet {
//    private var messages: [DailyMessages]
    private var messages: Dictionary<DateRepresentation,[Message]>
    private let queue: DispatchQueue
    weak var delegate: MessagesDateDelegate?
    
    init() {
//        self.messages = [DailyMessages]()
        self.messages = Dictionary<DateRepresentation,[Message]>()
        self.queue = DispatchQueue(label: "MessagesDataQueue")
    }
    
    func add(_ message: Message, update: Bool = true) {
        os_log("MESSAGE %{time_t}d", log: Logger.log(.dataSet), type: .debug, message.timestamp)
        self.queue.async {
            let date = DateRepresentation(message.timestamp)
            var daily = self.messages[date] ?? []
            daily.append(message)
            self.messages[date] = daily.sorted()
            if update {
                self.delegateData()
            }
        }
    }
    
    func add(_ messages: [Message]) {
        for message in messages {
            self.add(message, update: message == messages.last)
        }
    }
    
    func delegateData() {
        let allMessages = self.messages.sorted { (left: (key: DateRepresentation, value: [Message]?), right: (key: DateRepresentation, value: [Message]?)) -> Bool in
            return left.key < right.key
        }.compactMap { (key: DateRepresentation, value: [Message]?) -> [Message]? in
                return value
        }
        self.delegate?.messagesData(allMessages)
    }
    
    func remove(_ messageId: String) {
        
    }
}

//private class DailyMessages: Comparable {
//    private var messages: [Message]
//    let date: DateRepresentation
//
//    init(_ _date: DateRepresentation) {
//        self.date = _date
//        self.messages = [Message]()
//    }
//
//    static func <(lhs: DailyMessages, rhs: DailyMessages) -> Bool {
//        return lhs.date < rhs.date
//    }
//
//    static func ==(lhs: DailyMessages, rhs: DailyMessages) -> Bool {
//        return lhs.date == rhs.date
//    }
//}

private struct DateRepresentation: Hashable, Comparable {
    let day: Int
    let month: Int
    let year: Int
    var hashValue: Int {
        return "\(day).\(month).\(year)".hashValue
    }
    
    init(day d: Int, month m: Int, year y: Int) {
        self.day = d
        self.month = m
        self.year = y
    }
    
    init(_ time: TimeInterval) {
        let components = Set<Calendar.Component>(arrayLiteral: Calendar.Component.day, Calendar.Component.month, Calendar.Component.year)
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: time)
        let calculated = calendar.dateComponents(components, from: date)
        let day = calculated.day!
        let month = calculated.month!
        let year = calculated.year!
        self.init(day: day, month: month, year: year)
    }
    
    static func < (lhs: DateRepresentation, rhs: DateRepresentation) -> Bool {
        if lhs.year < rhs.year {
            return true
        } else if lhs.month < rhs.month {
            return true
        } else {
            return lhs.day < rhs.day
        }
    }
    
    static func == (lhs: DateRepresentation, rhs: DateRepresentation) -> Bool {
        return lhs.day == rhs.day && lhs.month == rhs.month && lhs.year == rhs.year
    }
}
