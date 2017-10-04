//
//  GroupsTableViewCellViewModel.swift
//  Glopie
//
//  Created by Luc on 03/10/2017.
//

import Foundation

class GroupsTableViewCellViewModel: NSObject, Codable {
    
    var rowHeight: Float
    var userImages: [String]
    var groupNameText: String
    var groupDetailText: String
    var groupTypeText: String
    var groupTypeColor: String
    
    override init() {
        rowHeight = 45.0
        userImages = []
        groupNameText = ""
        groupDetailText = ""
        groupTypeText = ""
        groupTypeColor = "212121"
        super.init()
    }
    
    init(rowHeight: Float,
         userImages: [String],
         groupNameText: String,
         groupDetailText: String,
         groupTypeText: String,
         groupTypeColor: String) {
        self.rowHeight = rowHeight
        self.userImages = userImages
        self.groupNameText = groupNameText
        self.groupDetailText = groupDetailText
        self.groupTypeText = groupTypeText
        self.groupTypeColor = groupTypeColor
    }
    
    static let empty = GroupsTableViewCellViewModel()
    
}
