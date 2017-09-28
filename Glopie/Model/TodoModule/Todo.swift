//
//  Todo.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class Todo: NSObject, Codable {
    var todoId: Int
    var user: User
    var detail: String
    var startDate: Date
    var endDate: Date
    var priority: Int
    
    override init() {
        todoId = 0
        user = User.empty
        detail = ""
        startDate = Date()
        endDate = Date()
        priority = 0
    }
    
    init(todoId: Int, user: User, detail: String, startDate: Date, endDate: Date, priority: Int) {
        self.todoId = todoId
        self.user = user
        self.detail = detail
        self.startDate = startDate
        self.endDate = endDate
        self.priority = priority
    }
    
    static let empty = Todo()
    
}
