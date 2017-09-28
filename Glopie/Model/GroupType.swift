//
//  GroupType.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation


class GroupType: NSObject, Codable {
    var groupTypeId: Int
    var name: String
    var groupTypeDescription: String
    var modules: [ModuleType]
    
    override init() {
        groupTypeId = 0
        name = ""
        groupTypeDescription = ""
        modules = []
    }
    
    init(groupTypeId: Int, name: String, groupTypeDescription: String, modules: [ModuleType]) {
        self.groupTypeId = groupTypeId
        self.name = name
        self.groupTypeDescription = groupTypeDescription
        self.modules = modules
    }
    
    static let empty = GroupType()
    
}
