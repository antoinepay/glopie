//
//  TargetSettings.swift
//  Glopie
//
//  Created by Antoine Payan on 27/09/2017.
//

import Foundation
import UIKit

struct TargetSettings {
    static let serverUrl = "http://vps402547.ovh.net/api/"
    static let authenticate = TargetSettings.serverUrl + "authenticate/social"
    static let userGroup = TargetSettings.serverUrl + "core/userGroup"
    static let groupType = TargetSettings.serverUrl + "core/groupType"

    static let mainColor = UIColor(hexString: "EB3349")
    static let secondColor = UIColor(hexString: "3EE1BC")
}
