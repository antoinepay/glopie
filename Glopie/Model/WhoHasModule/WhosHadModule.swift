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
    
    init(things: [Thing], moduleId: Int, moduleType: ModuleType, revision: Int, appVersion: String) {
        self.things = things
        super.init(moduleId: moduleId, moduleType: moduleType, revision: revision, appVersion: appVersion)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = WhoHasModule()
}
