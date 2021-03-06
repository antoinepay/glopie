//
//  Reminder.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class Reminder: NSObject, Codable {
    var reminderId: Int
    var user: User
    var detail: String
    var startDate: Date
    var endDate: Date
    
    override init() {
        reminderId = 0
        user = User.empty
        detail = ""
        startDate = Date()
        endDate = Date()
    }
    
    init(reminderId: Int, user: User, detail: String, startDate: Date, endDate: Date) {
        self.reminderId = reminderId
        self.user = user
        self.detail = detail
        self.startDate = startDate
        self.endDate = endDate
    }
    
    static let empty = Reminder()
    
}
