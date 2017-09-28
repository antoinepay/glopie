//
//  ReminderModule.swift
//  Glopie
//
//  Created by Luc on 28/09/2017.
//

import Foundation

class ReminderModule: ModuleGroup {
    var reminders: [Reminder]
    
    override init() {
        super.init()
        reminders = []
    }
    
    init(reminders: [Reminder], idModule: Int, moduleType: ModuleType, revision: Int, appVersion: String) {
        super.init(idModule: idModule, moduleType: moduleType, revision: revision, appVersion: appVersion)
        self.reminders = reminders
    }
    
    static let empty = ReminderModule()
}
