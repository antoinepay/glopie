//
//  GroupsTableViewCell.swift
//  Glopie
//
//  Created by Luc on 03/10/2017.
//

import UIKit
import SDWebImage

class GroupsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage1: UIImageView!
    @IBOutlet weak var userImage2: UIImageView!
    @IBOutlet weak var userImage3: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupDetail: UILabel!
    @IBOutlet weak var groupTypeLabel: UILabel!
    @IBOutlet weak var embedingViewGroupTypeLabel: UIView!
    
    func setup(model: GroupsTableViewCellViewModel) {
        accessoryType = .disclosureIndicator
        
        groupNameLabel.text = model.groupNameText
        groupNameLabel.textColor = UIColor(hexString: model.groupNameTextColor)
        groupNameLabel.textAlignment = NSTextAlignment.init(rawValue: model.labelsTextAlignment)!
        groupNameLabel.font = UIFont(name: model.labelsFontName, size: CGFloat(model.groupNameTextSize))
        
        groupDetail.text = model.groupDetailText
        groupDetail.textColor = UIColor(hexString: model.groupDetailTextColor)
        groupDetail.textAlignment = NSTextAlignment.init(rawValue: model.labelsTextAlignment)!
        groupDetail.font = UIFont(name: model.labelsFontName, size: CGFloat(model.groupDetailTextSize))
        
        groupTypeLabel.text = model.groupTypeText.uppercased()
        groupTypeLabel.textColor = UIColor(hexString: model.groupTypeTextColor)
        groupTypeLabel.textAlignment = NSTextAlignment.init(rawValue: model.labelsTextAlignment)!
        groupTypeLabel.font = UIFont(name: model.labelsFontName, size: CGFloat(model.groupTypeTextSize))
        
        embedingViewGroupTypeLabel.layer.borderWidth = CGFloat(model.groupTypeBorderWidth)
        embedingViewGroupTypeLabel.layer.borderColor = UIColor(hexString: model.groupTypeBorderColor).cgColor
        embedingViewGroupTypeLabel.layer.cornerRadius = 2
        embedingViewGroupTypeLabel.clipsToBounds = true
        let url = URL(string: User.retrieveFromUserDefaults()?.picture ?? "#")
        userImage1.sd_setImage(with: url, completed:nil)
        userImage1.clipsToBounds = true
        userImage1.layer.cornerRadius = userImage1.frame.size.width / 2.0
        userImage1.layer.borderColor = UIColor.white.cgColor
        userImage1.layer.borderWidth = 1.0
        userImage2.image = userImage2.image(with: User.retrieveFromUserDefaults() ?? User.empty)
        userImage2.clipsToBounds = true
        userImage2.layer.cornerRadius = userImage2.frame.size.width / 2.0
        userImage2.layer.borderColor = UIColor.white.cgColor
        userImage2.layer.borderWidth = 1.0
        userImage3.image = userImage3.image(with: User.retrieveFromUserDefaults() ?? User.empty)
        userImage3.clipsToBounds = true
        userImage3.layer.cornerRadius = userImage3.frame.size.width / 2.0
        userImage3.layer.borderColor = UIColor.white.cgColor
        userImage3.layer.borderWidth = 1.0
    }
    
}
