//
//  ModuleType.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation


class ModuleType: NSObject, Codable {
    var moduleTypeId: Int
    var name: String
    var detail: String
    var image: Data
    
    override init() {
        moduleTypeId = 0
        name = ""
        detail = ""
        image = Data()
    }
    
    init(moduleTypeId: Int, name: String, moduleTypeDescription: String, image: Data) {
        self.moduleTypeId = moduleTypeId
        self.name = name
        self.detail = detail
        self.image = image
    }
    
    static let empty = ModuleType()
}
