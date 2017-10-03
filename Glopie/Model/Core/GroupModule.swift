//
//  ModuleGroup.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class GroupModule: NSObject, Codable {
    var groupModuleId: String
    var moduleType: ModuleType
    var userGroupId: String
    var revision: Int
    
    override init() {
        groupModuleId = "0"
        userGroupId = "0"
        moduleType = ModuleType.empty
        revision = 0
    }
    
    init(groupModuleId: String, userGroupId: String, moduleType: ModuleType, revision: Int) {
        self.groupModuleId = groupModuleId
        self.userGroupId = userGroupId
        self.moduleType = moduleType
        self.revision = revision
    }
}
