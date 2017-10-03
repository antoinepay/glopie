//
//  WhosHadModule.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class WhoHasModule: GroupModule {
    var things: [Thing]
    
    override init() {
        things = []
        super.init()
    }
    
    init(things: [Thing], groupModuleId: String, userGroupId: String, moduleType: ModuleType, revision: Int) {
        self.things = things
        super.init(groupModuleId: groupModuleId, userGroupId: userGroupId, moduleType: moduleType, revision: revision)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = WhoHasModule()
}
