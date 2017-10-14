//
//  FriendTableViewCellViewModelMapper.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import Foundation
import SDWebImage

class FriendTableViewCellViewModelMapper {
    static func viewModels(_ facebookFriends:[FacebookFriend]) -> [FriendTableViewCellViewModel] {
        return facebookFriends.flatMap { facebookFriend in
            let imageView = UIImageView()
            let url = URL(string: facebookFriend.profilePictureLink)
            return FriendTableViewCellViewModel(id: facebookFriend.id, name: facebookFriend.name, image: url!)
        }
    }
}
