//
//  GroupTypeCollectionViewCell.swift
//  Glopie
//
//  Created by Antoine Payan on 05/10/2017.
//

import UIKit

class GroupTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var logo: UIImageView!
    @IBOutlet weak private var labelsStackView: UIStackView!
    @IBOutlet weak private var groupTitle: UILabel!
    @IBOutlet weak private var groupDetail: UILabel!

    func setup(viewModel: GroupTypeViewModel) {
        logo.image = viewModel.image
        logo.contentMode = .scaleAspectFill
        groupTitle.text = viewModel.name
        groupDetail.text = viewModel.detail
    }

}
