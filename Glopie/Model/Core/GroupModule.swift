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
    
    override init() {
        moduleId = 0
        moduleType = ModuleType.empty
        revision = 0
    }
    
    init(moduleId: Int, moduleType: ModuleType, revision: Int) {
        self.moduleId = moduleId
        self.moduleType = moduleType
        self.revision = revision
    }
}
