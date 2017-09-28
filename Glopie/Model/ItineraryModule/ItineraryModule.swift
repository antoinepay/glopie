//
//  WhosHadModule.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class ItineraryModule: GroupModule {
    var rents: [Rent]
    
    override init() {
        rents = []
        super.init()
    }
    
    init(rents: [Rent], moduleId: Int, moduleType: ModuleType, revision: Int, appVersion: String) {
        self.rents = rents
        super.init(moduleId: moduleId, moduleType: moduleType, revision: revision, appVersion: appVersion)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = ItineraryModule()
}



