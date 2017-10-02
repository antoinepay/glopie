//
//  User.swift
//  Glopie
//
//  Created by Antoine Payan on 27/09/2017.
//

import Foundation

enum LogType: String, Codable {
    case facebook
    case google
    case unknown
}

class User: NSObject, Codable {
    var externalId: String
    var firstname: String
    var lastname: String
    var email: String
    var token: String
    var logType: LogType
    var picture: String

    override init() {
        externalId = ""
        firstname = ""
        lastname = ""
        email = ""
        token = ""
        logType = .unknown
        picture = ""
    }

    init(externalId: String, firstname: String, lastname: String, email: String, token: String, logType: LogType, picture: String) {
        self.externalId = externalId
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.token = token
        self.logType = logType
        self.picture = picture
    }

    static let empty = User()

    static func saveToUserDefaults(_ user: User) {
        let propertyListEncoder = PropertyListEncoder()
        guard let data = try? propertyListEncoder.encode(user) else {
            return
        }
        UserDefaults.standard.set(data, forKey: "user")
        UserDefaults.standard.synchronize()
    }

    static func retrieveFromUserDefaults() -> User? {
        let propertyListDecoder = PropertyListDecoder()
        guard
            let data = UserDefaults.standard.data(forKey: "user"),
            let user = try? propertyListDecoder.decode(User.self, from: data) else {
            return nil
        }
        return user
    }

    static func eraseUserFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
    }

}
