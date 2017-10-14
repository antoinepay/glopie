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

    weak var delegate: GroupDetailTextEditDelegate?
    private var viewModel: GroupDetailTableViewCellViewModel?

    func configure(viewModel: GroupDetailTableViewCellViewModel, delegate: GroupDetailTextEditDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        titleLabel.text = viewModel.type.title()
        titleLabel.textColor = .lightGray
        valueTextField.text = viewModel.value
        valueTextField.isUserInteractionEnabled = viewModel.type.isEditable()
        valueTextField.placeholder = viewModel.type.placeholder()
        valueTextField.textColor = viewModel.type.isEditable() ? .black : .lightGray
        valueTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {
        guard let viewModel = viewModel else { return }
        delegate?.textFieldDidChange(for: viewModel.type, with: valueTextField.text ?? "")
    }

}
