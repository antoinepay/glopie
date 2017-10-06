//
//  GroupDetailTableViewCell.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import UIKit

class GroupDetailTableViewCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var valueTextField: UITextField!


    func configure(viewModel: GroupDetailTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.textColor = .lightGray
        valueTextField.text = viewModel.value
        valueTextField.isUserInteractionEnabled = viewModel.editable
        valueTextField.placeholder = viewModel.valuePlaceholder
        valueTextField.textColor = viewModel.editable ? .black : .lightGray
    }
}
