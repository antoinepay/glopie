//
//  GroupsTableViewCellViewModel.swift
//  Glopie
//
//  Created by Luc on 03/10/2017.
//

import Foundation

class GroupsTableViewCellViewModel: NSObject, Codable {
    
    var rowHeight: Float
    var labelsFontName: String
    var labelsTextAlignment: Int
    
    var userImages: [String]
    var userImagesHeight: Float
    var userImagesShift: Float
    
    var groupNameText: String
    var groupNameTextColor: String
    var groupNameTextSize: Float
    
    var groupDetailText: String
    var groupDetailTextColor: String
    var groupDetailTextSize: Float
    
    var groupTypeText: String
    var groupTypeTextColor: String
    var groupTypeTextSize: Float
    var groupTypeBorderWidth: Float
    var groupTypeBorderColor: String
    
    override init() {
        rowHeight = 45.0
        labelsFontName = "Avenir"
        labelsTextAlignment = 1
        userImages = []
        userImagesHeight = 40.0
        userImagesShift = 10.0
        groupNameText = ""
        groupNameTextSize = 15.0
        groupNameTextColor = "212121"
        groupDetailText = ""
        groupDetailTextSize = 14.0
        groupDetailTextColor = "212121"
        groupTypeText = ""
        groupTypeTextSize = 13.0
        groupTypeTextColor = "212121"
        groupTypeBorderColor = "9B9B9B"
        groupTypeBorderWidth = 2.0
        super.init()
    }
    
    init(rowHeight: Float, labelsFontName: String, labelsTextAlignment: Int, userImages: [String], userImagesHeight: Float, userImagesShift: Float, groupNameText: String, groupNameTextSize: Float, groupNameTextColor: String, groupDetailText: String, groupDetailTextSize: Float, groupDetailTextColor: String, groupTypeText: String, groupTypeTextSize: Float, groupTypeTextColor: String, groupTypeBorderColor: String, groupTypeBorderWidth: Float) {
        self.rowHeight = rowHeight
        self.labelsFontName = labelsFontName
        self.labelsTextAlignment = labelsTextAlignment
        self.userImages = userImages
        self.userImagesHeight = userImagesHeight
        self.userImagesShift = userImagesShift
        self.groupNameText = groupNameText
        self.groupNameTextSize = groupNameTextSize
        self.groupNameTextColor = groupNameTextColor
        self.groupDetailText = groupDetailText
        self.groupDetailTextSize = groupDetailTextSize
        self.groupDetailTextColor = groupDetailTextColor
        self.groupTypeText = groupTypeText
        self.groupTypeTextSize = groupTypeTextSize
        self.groupTypeTextColor = groupTypeTextColor
        self.groupTypeBorderColor = groupTypeBorderColor
        self.groupTypeBorderWidth = groupTypeBorderWidth
    }
    
    static let empty = GroupsTableViewCellViewModel()
    
}
