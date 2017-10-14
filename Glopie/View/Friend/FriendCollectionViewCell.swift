//
//  FriendCollectionViewCell.swift
//  Glopie
//
//  Created by Antoine Payan on 13/10/2017.
//

import UIKit
import SDWebImage

class FriendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var image: UIImageView!

    func configure(with facebookUser: FacebookFriend) {
        name.text = facebookUser.name
        let url = URL(string: facebookUser.profilePictureLink)
        self.image.clipsToBounds = true
        image.sd_setImage(with: url, completed: { (_,_,_,_) in
            self.image.layer.cornerRadius = self.image.frame.size.width / 2.0
        })

    }

}
