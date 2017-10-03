//
//  AccountTableViewCellViewModel.swift
//  Glopie
//
//  Created by Luc on 02/10/2017.
//

import Foundation
import UIKit

class AccountTableViewCellViewModel: NSObject, Codable {
    
    var labelText: String
    var labelTextColor: String
    var labelFontName: String
    var labelFontSize: Float
    var rowHeight: Float
    var labelTextAlignment: Int
    
    override init() {
        labelText = "Label"
        labelTextColor = "#212121"
        labelFontName = "Avenir"
        labelFontSize = 15
        rowHeight = 45.0
        labelTextAlignment = 1
    }
    
    init(labelText: String, labelTextColor: String, labelFontName: String, labelFontSize: Float, rowHeight: Float, labelTextAlignment: Int) {
        self.labelText = labelText
        self.labelTextColor = labelTextColor
        self.labelFontName = labelFontName
        self.labelFontSize = labelFontSize
        self.rowHeight = rowHeight
        self.labelTextAlignment = labelTextAlignment
    }
    
    static let empty = AccountTableViewCellViewModel()
}
