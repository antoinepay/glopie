//
//  File.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class TodoModule: GroupModule {
    var todos: [Todo]
    
    override init() {
        todos = []
        super.init()
    }
    
    init(todos: [Todo], moduleId: Int, moduleType: ModuleType, revision: Int) {
        self.todos = todos
        super.init(moduleId: moduleId, moduleType: moduleType, revision: revision)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = TodoModule()
}
