//
//  ModuleGroup.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class GroupModule: NSObject, Codable {
    var moduleId: Int
    var moduleType: ModuleType
    var revision: Int
    var appVersion: String
    
    override init() {
        moduleId = 0
        moduleType = ModuleType.empty
        revision = 0
        appVersion = ""
    }
    
    init(moduleId: Int, moduleType: ModuleType, revision: Int, appVersion: String) {
        self.moduleId = moduleId
        self.moduleType = moduleType
        self.revision = revision
        self.appVersion = appVersion
    }
}
