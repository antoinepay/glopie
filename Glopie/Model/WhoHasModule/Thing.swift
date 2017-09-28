//
//  Thing.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class Thing: NSObject, Codable {
    var thingId: Int
    var title: String
    var detail: String
    var image: Data
    var date: Date
    var owner: User
    var previousOwner: User
    var nextOwner: User
    
    override init() {
        thingId = 0
        title = ""
        detail = ""
        image = Data()
        date = Date()
        owner =  User.empty
        previousOwner = User.empty
        nextOwner = User.empty
    }
    
    init(thingId: Int, title: String, detail: String, image: Data, date: Date, owner: User, previousOwner: User, nextOwner: User) {
        self.thingId = thingId
        self.title = title
        self.detail = detail
        self.image = image
        self.date = date
        self.owner = owner
        self.previousOwner = previousOwner
        self.nextOwner = nextOwner
    }
    
    static let empty = Thing()
}
