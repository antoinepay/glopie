//
//  ModuleGroup.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class GroupModule: NSObject, Codable {
    var idModule: Int
    var moduleType: ModuleType
    var revision: Int
    var appVersion: String
    
    override init() {
        idModule = 0
        moduleType = ModuleType.empty
        revision = 0
        appVersion = ""
    }
    
    init(idModule: Int, moduleType: ModuleType, revision: Int, appVersion: String) {
        self.idModule = idModule
        self.moduleType = moduleType
        self.revision = revision
        self.appVersion = appVersion
    }
}
