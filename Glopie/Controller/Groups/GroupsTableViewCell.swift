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
        let userImages = [userImage1, userImage2, userImage3]
        groupNameLabel.text = model.groupNameText
        groupDetail.text = model.groupDetailText
        groupTypeLabel.text = model.groupTypeText.uppercased()
        groupTypeLabel.textColor = UIColor(hexString: model.groupTypeColor)
        groupTypeLabel.font = UIFont(name: groupTypeLabel.font.fontName, size: 10.0)
        embedingViewGroupTypeLabel.layer.borderWidth = 1.0
        embedingViewGroupTypeLabel.layer.borderColor = UIColor(hexString: model.groupTypeColor).cgColor
        embedingViewGroupTypeLabel.layer.cornerRadius = 2
        embedingViewGroupTypeLabel.clipsToBounds = true

        for i in 0...min(2, model.userImages.count - 1) {
            let url = URL(string: model.userImages[i])
            if let userImage = userImages[i] {
                userImage.sd_setImage(with: url, completed:nil)
                userImage.clipsToBounds = true
                userImage.layer.cornerRadius = userImage.frame.size.width / 2.0
                userImage.layer.borderColor = UIColor.white.cgColor
                userImage.layer.borderWidth = 1.0
            }
        }
    }
    
}
