//
//  WhosHadModule.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class ExpenseModule: GroupModule {
    var expenses: [Expense]
    
    override init() {
        expenses = []
        super.init()
    }
    
    init(expenses: [Expense], moduleId: Int, moduleType: ModuleType, revision: Int, appVersion: String) {
        self.expenses = expenses
        super.init(moduleId: moduleId, moduleType: moduleType, revision: revision, appVersion: appVersion)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = ExpenseModule()
}

