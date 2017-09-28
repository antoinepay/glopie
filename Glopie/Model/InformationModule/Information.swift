//
//  Information.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation


class Information: NSObject, Codable {
    var informationId: Int
    var name: String
    var detail : String
    var image: Data
    
    override init(){
        informationId = 0
        name = ""
        detail = ""
        image = Data()
    }
    
    init(informationId: Int, name: String, detail: String, image: Data) {
        self.informationId = informationId
        self.name = name
        self.detail = detail
        self.image = image
    }
    
    static let empty = Information()
}
