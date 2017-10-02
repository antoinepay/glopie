//
//  WhosHadModule.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class InformationModule: GroupModule {
    var informations: [Information]
    
    override init() {
        informations = []
        super.init()
    }
    
    init(informations: [Information], moduleId: Int, moduleType: ModuleType, revision: Int) {
        self.informations = informations
        super.init(moduleId: moduleId, moduleType: moduleType, revision: revision)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = InformationModule()
}


