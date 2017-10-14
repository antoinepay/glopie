//
//  ModuleSelectionTableViewCell.swift
//  Glopie
//
//  Created by Antoine Payan on 05/10/2017.
//

import UIKit

class ModuleSelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var roundView: UIView!

    private var viewModel: ModuleTypeViewModel?
    var isModuleSelected: Bool = false

    override func setSelected(_ selected: Bool, animated: Bool) {
        updateState()
    }

    func setup(viewModel: ModuleTypeViewModel, isModuleSelected: Bool) {
        logo.image = viewModel.logo.withRenderingMode(.alwaysTemplate)
        logo.contentMode = .scaleAspectFill
        nameLabel.text = viewModel.name
        detailLabel.text = viewModel.detail
        roundView.layer.cornerRadius = roundView.frame.size.width / 2.0
        roundView.clipsToBounds = true
        roundView.layer.borderWidth = 2.0
        roundView.layer.borderColor = viewModel.color.cgColor
        self.viewModel = viewModel
        self.isModuleSelected = isModuleSelected
        updateState()
    }

    func updateState() {
        self.isModuleSelected = !self.isModuleSelected
        guard let viewModel = viewModel else { return }
        UIView.animate(withDuration: 0.3, animations: {
            if self.isModuleSelected {
                self.roundView.backgroundColor = viewModel.color
                self.logo.tintColor = .white
                self.contentView.alpha = 1.0
                self.contentView.backgroundColor = .white
            } else {
                self.roundView.backgroundColor = .clear
                self.logo.tintColor = viewModel.color
                self.contentView.backgroundColor = UIColor(hexString: "#DCDCDC")
                self.contentView.alpha = 0.5
            }}, completion: { finished in  })
    }


    
}
