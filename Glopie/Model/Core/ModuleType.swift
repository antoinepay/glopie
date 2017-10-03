//
//  ModuleType.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation


class ModuleType: NSObject, Codable {
    var moduleTypeId: String
    var name: String
    var detail: String
    var image: Data
    var appVersion: String
    
    override init() {
        moduleTypeId = "0"
        name = ""
        detail = ""
        image = Data()
        appVersion = ""
    }
    
    init(moduleTypeId: String, name: String, detail: String, image: Data, appVersion: String) {
        self.moduleTypeId = moduleTypeId
        self.name = name
        self.detail = detail
        self.image = image
        self.appVersion = appVersion
    }
    
    static let empty = ModuleType()
}
