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
    var detail: String
    var modules: [ModuleType]
    
    override init() {
        groupTypeId = 0
        name = ""
        detail = ""
        modules = []
    }
    
    init(groupTypeId: Int, name: String, detail: String, modules: [ModuleType]) {
        self.groupTypeId = groupTypeId
        self.name = name
        self.detail = detail
        self.modules = modules
    }
    
    static let empty = GroupType()
    
}
