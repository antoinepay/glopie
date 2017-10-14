//
//  FriendTableViewCell.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak private var selectionStateView: UIView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var profilePicture: UIImageView!

    private var viewModel: FriendTableViewCellViewModel?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        UIView.animate(withDuration: 0.3, animations: {
            if selected {
                self.selectionStateView.layer.borderColor = TargetSettings.mainColor.cgColor
                self.selectionStateView.backgroundColor = TargetSettings.mainColor
            } else {
                self.selectionStateView.layer.borderColor = UIColor.lightGray.cgColor
                self.selectionStateView.backgroundColor = .clear
            }
        })
    }

    func setup(viewModel: FriendTableViewCellViewModel) {
        selectionStateView.layer.cornerRadius = selectionStateView.frame.size.width / 2.0
        selectionStateView.layer.borderWidth = 1.0
        nameLabel.text = viewModel.name
        profilePicture.sd_setImage(with: viewModel.image, placeholderImage: #imageLiteral(resourceName: "GlopieIcon"), options: [], completed: nil)
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2.0
        profilePicture.clipsToBounds = true
        self.viewModel = viewModel
    }
    
}
