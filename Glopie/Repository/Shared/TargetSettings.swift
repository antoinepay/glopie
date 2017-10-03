//
//  TargetSettings.swift
//  Glopie
//
//  Created by Antoine Payan on 27/09/2017.
//

import Foundation

struct TargetSettings {
    static let serverUrl = "http://vps402547.ovh.net/api/"
    static let authenticate = TargetSettings.serverUrl + "authenticate/social"
    static let userGroup = TargetSettings.serverUrl + "core/userGroup"
}
