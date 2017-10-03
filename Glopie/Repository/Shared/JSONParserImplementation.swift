import Foundation
import FBSDKLoginKit
import GoogleSignIn

protocol JSONParser {
    func parseFacebookResponse(user: [String: Any], from type: LogType) -> User
    func parseAPIResponse(user: [String: Any], from type: LogType) -> User
    func parseUserGroups(groups: [Any]) -> [UserGroup]
}

class JSONParserImplementation: JSONParser {

    //MARK: - JSONParser

    func parseFacebookResponse(user: [String : Any], from type: LogType) -> User {
        guard
            let externalId = user["id"] as? String,
            let firstname = user["first_name"] as? String,
            let lastname = user["last_name"] as? String,
            let email = user["email"] as? String,
            let pictureObject = user["picture"] as? [String:Any],
            let pictureData = pictureObject["data"] as? [String:Any],
            let picture = pictureData["url"] as? String,
            let token = FBSDKAccessToken.current().tokenString else {
                return User.empty
            }
        return User(
            externalId: externalId,
            firstname: firstname,
            lastname: lastname,
            email: email,
            token: token,
            logType: .facebook,
            picture: picture
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
            let email = user["email"] as? String,
            let picture = user["picture"] as? String else {
                return User.empty
        }
        return User(
            externalId: externalId,
            firstname: firstname,
            lastname: lastname,
            email: email,
            token: token,
            logType: .facebook,
            picture: picture
        )
    }

    func parseUserGroups(groups: [Any]) -> [UserGroup] {
        return groups.flatMap { group in
            guard
                let group = group as? [String:Any],
                let id = group["_id"] as? String,
                let name = group["name"] as? String,
                let detail = group["detail"] as? String,
                let accessCode = group["accessCode"] as? String,
                let groupTypeId = group["groupType"] as? String,
                let groupModulesArray = group["groupModules"] as? [Any],
                let usersArray = group["users"] as? [Any],
                let pendingUsersArray = group["pendingUsers"] as? [Any] else { return nil }
            let users = self.parseOtherUsers(from: usersArray)
            let pendingUsers = self.parseOtherUsers(from: pendingUsersArray)
            let groupModules = self.parseGroupModules(from: groupModulesArray)
            let groupType = GroupType.empty
            groupType.groupTypeId = groupTypeId
            return UserGroup(
                userGroupId: id,
                name: name,
                detail: detail,
                accessCode: accessCode,
                groupType: groupType,
                modulesGroup: groupModules,
                users: users,
                usersPending: pendingUsers
            )
            }
        }


    private func parseOtherUsers(from array: [Any]) -> [User] {
        return array.flatMap { user in
            let u = User.empty
            guard
                let user = user as? [String:Any],
                let email = user["email"] as? String,
                let firstname = user["firstname"] as? String,
                let lastname = user["lastname"] as? String,
                let picture = user["picture"] as? String,
                let logType = user["logType"] as? String
                else { return nil }
            u.email = email
            u.firstname = firstname
            u.lastname = lastname
            u.logType = logType == "facebook" ? .facebook : .google
            u.picture = picture
            return u
        }
    }

    private func parseGroupModules(from array: [Any]) -> [GroupModule] {
        return array.flatMap { groupModule in
            guard
                let groupModule = groupModule as? [String:Any],
                let id = groupModule["_id"] as? String,
                let moduleTypeId = groupModule["moduleType"] as? String,
                let userGroup = groupModule["userGroup"] as? String,
                let revision = groupModule["revision"] as? Int else { return nil }
            let moduleType = ModuleType.empty
            moduleType.moduleTypeId = moduleTypeId
            return GroupModule(
                groupModuleId: id,
                userGroupId: userGroup,
                moduleType: moduleType,
                revision: revision
            )
        }
    }

}
