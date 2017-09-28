//
//  Location.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation
import UIKit

class Rent: NSObject, Codable {
    var rentId: Int
    var name: String
    var detail: String
    var startDate: Date
    var endDate: Date
    var externalLink: String
    var price: CGFloat
    
    override init() {
        rentId = 0
        name = ""
        detail = ""
        startDate = Date()
        endDate = Date()
        externalLink = ""
        price = 0.0
    }
    
    init(rentId: Int, name: String, detail: String, startDate: Date, endDate: Date, externalLink: String, price: CGFloat ) {
        self.rentId = rentId
        self.name = name
        self.detail = detail
        self.startDate = startDate
        self.endDate = endDate
        self.externalLink = externalLink
        self.price = price
    }
    
    static let empty = Rent()
    
}
