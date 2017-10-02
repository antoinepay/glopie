//
//  String.swift
//  Glopie
//
//  Created by Luc on 29/09/2017.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
