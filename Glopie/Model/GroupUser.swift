
//
//  Groupuser.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation


class GroupUser: NSObject, Codable {
    var groupUserId: Int
    var name: String
    var groupUserDescription: String
    var accessCode: String
    var groupType: GroupType
    var modulesGroup: [ModuleGroup]
    var users: [User]
    var usersPending: [User]
    
    override init() {
        groupUserId = 0
        name = ""
        groupUserDescription = ""
        accessCode = ""
        groupType = GroupType.empty
        modulesGroup = []
        users = []
        usersPending = []
    }
    
    init(groupUserId: Int, name: String, groupUserDescription: String, accessCode: String, groupType: GroupType, modulesGroup: [ModuleGroup], users: [User], usersPending: [User]){
        self.groupUserId = groupUserId
        self.name = name
        self.groupUserDescription = groupUserDescription
        self.accessCode = accessCode
        self.groupType = groupType
        self.modulesGroup = modulesGroup
        self.users =  users
        self.usersPending = usersPending
    }
    
    static let empty = GroupUser()
    
    
}
