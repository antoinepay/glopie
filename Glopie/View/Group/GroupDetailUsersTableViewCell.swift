//
//  GroupDetailUsersTableViewCell.swift
//  Glopie
//
//  Created by Antoine Payan on 13/10/2017.
//

import UIKit

class GroupDetailUsersTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var addUserButton: UIButton!

    private var facebookFriends: [FacebookFriend] = []

    weak var delegate: GroupAddUsersDelegate?

    override func awakeFromNib() {
        setupButton()
        let nib = UINib(nibName: "FriendCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FriendCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return facebookFriends.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as? FriendCollectionViewCell {
            cell.configure(with: facebookFriends[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

    func setup(with facebookFriends: [FacebookFriend], delegate: GroupAddUsersDelegate) {
        self.delegate = delegate
        self.facebookFriends = facebookFriends
        collectionView.reloadData()
    }

    private func setupButton() {
        addUserButton.setTitle("addUsersToGroup".localized(), for: .normal)
        addUserButton.setTitleColor(.white, for: .normal)
        addUserButton.titleLabel?.font = UIFont(name: "Avenir", size: 15.0)
        addUserButton.backgroundColor = UIColor(hexString: "3C5193")
        addUserButton.layer.cornerRadius = 4
        addUserButton.setImage(UIImage(named: "facebookIcon"), for: UIControlState.normal)
        addUserButton.tintColor = .white
        addUserButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        addUserButton.addTarget(self, action: #selector(presentUsersListAction(_:)), for: .touchUpInside)
        addUserButton.clipsToBounds = true
    }

    @objc private func presentUsersListAction(_ sender: Any) {
        delegate?.presentUsersList()
    }
}
