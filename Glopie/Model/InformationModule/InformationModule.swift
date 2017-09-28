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
    
    init(informations: [Information], idModule: Int, moduleType: ModuleType, revision: Int, appVersion: String) {
        self.informations = informations
        super.init(idModule: idModule, moduleType: moduleType, revision: revision, appVersion: appVersion)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = InformationModule()
}


