//
//  ModuleTypeViewModelMapper.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import Foundation
import UIKit

class ModuleTypeViewModelMapper {
    static func viewModels(_ moduleTypes: [ModuleType]) -> [ModuleTypeViewModel] {
        return moduleTypes.flatMap { moduleType in
            let logo = UIImage(data: moduleType.image) ?? UIImage()
            let color = UIColor(hexString: moduleType.backgroundColor)
            let addButtonColor = UIColor(hexString: moduleType.addButtonBackgroundColor)
            return ModuleTypeViewModel(
                logo: logo,
                color: color,
                name: moduleType.name,
                detail: moduleType.detail,
                addButtonColor: addButtonColor
            )
        }
    }

    static func viewModel(_ moduleType: ModuleType) -> ModuleTypeViewModel {
        let logo = UIImage(data: moduleType.image) ?? UIImage()
        let color = UIColor(hexString: moduleType.backgroundColor)
        let addButtonColor = UIColor(hexString: moduleType.addButtonBackgroundColor)
        return ModuleTypeViewModel(
            logo: logo,
            color: color,
            name: moduleType.name,
            detail: moduleType.detail,
            addButtonColor: addButtonColor
        )
    }
}
