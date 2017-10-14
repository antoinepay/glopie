
//
//  Groupuser.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation


class UserGroup: NSObject, Codable {
    var userGroupId: String
    var name: String
    var detail: String
    var accessCode: String
    var groupType: GroupType
    var groupModules: [GroupModule]
    var users: [User]
    var usersPending: [User]
    var image: Data
    
    override init() {
        userGroupId = "0"
        name = ""
        detail = ""
        accessCode = ""
        groupType = GroupType.empty
        groupModules = []
        users = []
        usersPending = []
        image = Data()
    }
    
    init(userGroupId: String, name: String, detail: String, accessCode: String, groupType: GroupType, groupModules: [GroupModule], users: [User], usersPending: [User], image: Data){
        self.userGroupId = userGroupId
        self.name = name
        self.detail = detail
        self.accessCode = accessCode
        self.groupType = groupType
        self.groupModules = groupModules
        self.users =  users
        self.usersPending = usersPending
        self.image = image
    }
    
    static let empty = UserGroup()
    
    
}
