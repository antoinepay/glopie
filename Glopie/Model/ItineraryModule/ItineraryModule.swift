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
    
    init(rents: [Rent], groupModuleId: String, userGroupId: String, moduleType: ModuleType, revision: Int) {
        self.rents = rents
        super.init(groupModuleId: groupModuleId, userGroupId: userGroupId, moduleType: moduleType, revision: revision)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = ItineraryModule()
}



