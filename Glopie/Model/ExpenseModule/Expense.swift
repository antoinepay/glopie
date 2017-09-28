//
//  Expense.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation


class Expense: NSObject, Codable {
    var expenseId: Int
    var buyers: [User]
    var receivers: [User]
    var amountUser: [AmountUser]
    var name: String
    var detail: String
    var date: Date
    
    override init() {
        expenseId = 0
        buyers = []
        receivers = []
        amountUser = []
        name = ""
        detail = ""
        date = Date()
    }
    
    init(expenseId: Int, buyers: [User], receivers: [User],amountUser: [AmountUser], name: String, detail: String, date: Date) {
        self.expenseId = expenseId
        self.buyers = buyers
        self.receivers = receivers
        self.amountUser = amountUser
        self.name = name
        self.detail = detail
        self.date = date
    }
    
    static let empty = Expense()
}
