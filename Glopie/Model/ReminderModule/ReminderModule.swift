//
//  ReminderModule.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class ReminderModule: GroupModule {
    var reminders: [Reminder]
    
    override init() {
        reminders = []
        super.init()
    }
    
    init(reminders: [Reminder], groupModuleId: String, userGroupId: String, moduleType: ModuleType, revision: Int) {
        self.reminders = reminders
        super.init(groupModuleId: groupModuleId, userGroupId: userGroupId, moduleType: moduleType, revision: revision)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let empty = ReminderModule()
}
