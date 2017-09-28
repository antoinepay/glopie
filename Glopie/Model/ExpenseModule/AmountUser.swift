//
//  AmountUser.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation
import UIKit

class AmountUser: NSObject, Codable {
    var amountUserId: Int
    var user: User
    var amount: CGFloat

    override init() {
        amountUserId = 0
        user = User.empty
        amount = 0.0
    }
    
    init(amountUserId: Int, user: User, amount: CGFloat) {
        self.user = user
        self.amountUserId = amountUserId
        self.amount = amount
    }
    
    static let empty = AmountUser()
}
