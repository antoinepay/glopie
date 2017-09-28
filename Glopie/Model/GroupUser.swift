
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
    var detail: String
    var accessCode: String
    var groupType: GroupType
    var modulesGroup: [GroupModule]
    var users: [User]
    var usersPending: [User]
    
    override init() {
        groupUserId = 0
        name = ""
        detail = ""
        accessCode = ""
        groupType = GroupType.empty
        modulesGroup = []
        users = []
        usersPending = []
    }
    
    init(groupUserId: Int, name: String, detail: String, accessCode: String, groupType: GroupType, modulesGroup: [GroupModule], users: [User], usersPending: [User]){
        self.groupUserId = groupUserId
        self.name = name
        self.detail = detail
        self.accessCode = accessCode
        self.groupType = groupType
        self.modulesGroup = modulesGroup
        self.users =  users
        self.usersPending = usersPending
    }
    
    static let empty = GroupUser()
    
    
}
