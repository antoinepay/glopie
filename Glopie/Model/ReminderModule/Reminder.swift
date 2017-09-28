//
//  Reminder.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class Reminder: NSObject, Codable {
    var user: User
    var detail: String
    
    override init() {
        user = User.empty
        detail = ""
    }
    
    init(user: User, detail: String) {
        self.user = user
        self.detail = detail
    }
    
    static let empty = Reminder()
    
}
