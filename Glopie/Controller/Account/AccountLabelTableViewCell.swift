//
//  AccountTableViewCell.swift
//  Glopie
//
//  Created by Luc on 02/10/2017.
//

import UIKit

class AccountLabelTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var placeholder: UILabel!
    @IBOutlet weak private var value: UILabel!
    
    func setup(model: AccountTableViewCellLabelViewModel) {
        placeholder?.text = model.labelText
        placeholder?.textColor = UIColor(hexString: model.labelTextColor)
        placeholder?.font = UIFont(name: model.labelFontName, size: CGFloat(model.labelFontSize))
        placeholder?.textAlignment = NSTextAlignment.init(rawValue: model.labelTextAlignment)!
        
        value?.text = model.valueText
        value?.textColor = UIColor(hexString: model.valueTextColor)
        value?.font = UIFont(name: model.valueFontName, size: CGFloat(model.valueFontSize))
        value?.textAlignment = NSTextAlignment.init(rawValue: model.valueTextAlignment)!
    }
    
}

