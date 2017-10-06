//
//  GroupDetailHeaderView.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import UIKit

class GroupDetailHeaderView: UIView {

    @IBOutlet weak private var addImageButton: UIButton!
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var groupLogo: UIImageView!

    var delegate: GroupDetailHeaderViewDelegate?

    init(frame: CGRect, delegate: GroupDetailHeaderViewDelegate) {
        self.delegate = delegate
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("GroupDetailHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addImageButton.backgroundColor = TargetSettings.secondColor
        addImageButton.addTarget(self, action: #selector(addImageAction(_:)), for: .touchUpInside)
        addImageButton.layer.cornerRadius = addImageButton.frame.size.width / 2.0
        groupLogo.contentMode = .scaleAspectFill
    }

    func configure(logo: UIImage) {
        groupLogo.image = logo
        groupLogo.clipsToBounds = true
        groupLogo.layer.cornerRadius = groupLogo.frame.size.width / 2.0
    }

    @objc private func addImageAction(_ sender: UIButton) {
        delegate?.addImageChoice()
    }



}
