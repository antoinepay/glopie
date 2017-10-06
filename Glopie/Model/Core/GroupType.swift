//
//  GroupType.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation


class GroupType: NSObject, Codable {
    var groupTypeId: String
    var name: String
    var detail: String
    var logo: Data
    var modules: [ModuleType]
    
    override init() {
        groupTypeId = "0"
        name = ""
        detail = ""
        modules = []
        logo = Data()
    }
    
    init(groupTypeId: String, name: String, detail: String, logo: Data, modules: [ModuleType]) {
        self.groupTypeId = groupTypeId
        self.name = name
        self.detail = detail
        self.logo = logo
        self.modules = modules
    }
    
    static let empty = GroupType()
    
}
