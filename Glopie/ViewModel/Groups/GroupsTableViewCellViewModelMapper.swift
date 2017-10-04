//
//  GroupsTableViewCellViewModelMapper.swift
//  Glopie
//
//  Created by Antoine Payan on 04/10/2017.
//

import Foundation
import UIKit

class GroupsTableViewCellViewModelMapper {
    static func viewModels(from userGroups: [UserGroup]) -> [GroupsTableViewCellViewModel] {
        let viewModels: [GroupsTableViewCellViewModel] = userGroups.flatMap { userGroup in
            let viewModel = GroupsTableViewCellViewModel(
                rowHeight: 100,
                userImages: userGroup.users.flatMap { user in return user.picture },
                groupNameText: userGroup.name,
                groupDetailText: userGroup.detail,
                groupTypeText: userGroup.groupType.name,
                groupTypeColor: "#ff0000"
            )
            return viewModel
        }
        return viewModels
    }
}
