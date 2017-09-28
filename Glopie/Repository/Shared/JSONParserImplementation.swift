import Foundation
import FBSDKLoginKit
import GoogleSignIn

protocol JSONParser {
    func parseFacebookResponse(user: [String: Any], from type: LogType) -> User
    func parseAPIResponse(user: [String: Any], from type: LogType) -> User
}

class JSONParserImplementation: JSONParser {

    //MARK: - JSONParser

    func parseFacebookResponse(user: [String : Any], from type: LogType) -> User {
        guard
            let externalId = user["id"] as? String,
            let firstname = user["first_name"] as? String,
            let lastname = user["last_name"] as? String,
            let email = user["email"] as? String,
            let token = FBSDKAccessToken.current().tokenString else {
                return User.empty
            }
        return User(
            externalId: externalId,
            firstname: firstname,
            lastname: lastname,
            email: email,
            token: token,
            logType: .facebook
        )
    }

    func parseAPIResponse(user: [String : Any], from type: LogType) -> User {
        var token = ""
        if type == .facebook {
            token = FBSDKAccessToken.current().tokenString
        } else if type == .google {
            token = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
        }
        guard
            let externalId = user["externalId"] as? String,
            let firstname = user["firstname"] as? String,
            let lastname = user["lastname"] as? String,
            let email = user["email"] as? String else {
                return User.empty
        }
        return User(
            externalId: externalId,
            firstname: firstname,
            lastname: lastname,
            email: email,
            token: token,
            logType: .facebook
        )
    }
}
