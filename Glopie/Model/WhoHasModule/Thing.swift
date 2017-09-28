//
//  Thing.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class Thing: NSObject, Codable {
    var thingId: Int
    var name: String
    var detail: String
    var image: Data
    var date: Date
    var owner: User
    var previousOwner: User
    var nextOwner: User
    
    override init() {
        thingId = 0
        name = ""
        detail = ""
        image = Data()
        date = Date()
        owner =  User.empty
        previousOwner = User.empty
        nextOwner = User.empty
    }
    
    init(thingId: Int, name: String, detail: String, image: Data, date: Date, owner: User, previousOwner: User, nextOwner: User) {
        self.thingId = thingId
        self.name = name
        self.detail = detail
        self.image = image
        self.date = date
        self.owner = owner
        self.previousOwner = previousOwner
        self.nextOwner = nextOwner
    }
    
    static let empty = Thing()
}
