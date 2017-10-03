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
    
    init(expenses: [Expense], groupModuleId: String, userGroupId: String, moduleType: ModuleType, revision: Int) {
        self.expenses = expenses
        super.init(groupModuleId: groupModuleId, userGroupId: userGroupId, moduleType: moduleType, revision: revision)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = ExpenseModule()
}

