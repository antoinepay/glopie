//
//  GroupTypeViewModelMapper.swift
//  Glopie
//
//  Created by Antoine Payan on 05/10/2017.
//

import Foundation
import UIKit

class GroupTypeViewModelMapper {
    static func viewModels(from groupTypes: [GroupType]) -> [GroupTypeViewModel] {
        return groupTypes.flatMap { groupType in
            let logo = UIImage(data: groupType.logo) ?? UIImage()
            return GroupTypeViewModel(
                id: groupType.groupTypeId,
                image: logo,
                name: groupType.name,
                detail: groupType.detail
            )
        }
    }
}
