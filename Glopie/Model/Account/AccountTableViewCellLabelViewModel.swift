//
//  AccountTableViewCellLabelViewModel.swift
//  Glopie
//
//  Created by Luc on 02/10/2017.
//

import Foundation
import UIKit

class AccountTableViewCellLabelViewModel: AccountTableViewCellViewModel {
    
    var valueText: String
    var valueTextColor: String
    var valueFontName: String
    var valueFontSize: Float
    var valueTextAlignment: Int
    
    override init() {
        valueText = "Label"
        valueTextColor = "#212121"
        valueFontName = "Avenir"
        valueFontSize = 15
        valueTextAlignment = 1
        super.init()
    }
    
    init(labelText: String, labelTextColor: String, labelFontName: String, labelFontSize: Float, rowHeight: Float, labelTextAlignment: Int, valueText: String, valueTextColor: String, valueFontName: String, valueFontSize: Float, valueTextAlignment: Int) {
        self.valueText = valueText
        self.valueTextColor = valueTextColor
        self.valueFontName = valueFontName
        self.valueFontSize = valueFontSize
        self.valueTextAlignment = valueTextAlignment
        super.init(labelText: labelText, labelTextColor: labelTextColor, labelFontName: labelFontName, labelFontSize: labelFontSize, rowHeight: rowHeight, labelTextAlignment: labelTextAlignment)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
