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
    var appVersion: Int
    var backgroundColor: String
    var addButtonBackgroundColor: String
    
    override init() {
        moduleTypeId = "0"
        name = ""
        detail = ""
        image = Data()
        appVersion = 0
        backgroundColor = "#ffffff"
        addButtonBackgroundColor = "#000000"
    }
    
    init(moduleTypeId: String, name: String, detail: String, image: Data, appVersion: Int, backgroundColor: String, addButtonBackgroundColor: String) {
        self.moduleTypeId = moduleTypeId
        self.name = name
        self.detail = detail
        self.image = image
        self.appVersion = appVersion
        self.backgroundColor = backgroundColor
        self.addButtonBackgroundColor = addButtonBackgroundColor
    }
    
    static let empty = ModuleType()
}
