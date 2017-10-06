import Foundation
import FBSDKLoginKit
import GoogleSignIn

protocol JSONParser {
    func parseFacebookResponse(user: [String: Any], from type: LogType) -> User
    func parseAPIResponse(user: [String: Any], from type: LogType) -> User
    func parseUserGroups(groups: [Any]) -> [UserGroup]
    func parseGroupTypes(groupTypes: [Any], moduleTypes: [Any]) -> ([GroupType], [ModuleType])
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
                let accessCode = group["accessCode"] as? String,
                let groupTypeArray = group["groupType"] as? [String:Any],
                let groupTypeName = groupTypeArray["name"] as? String,
                let groupTypeId = groupTypeArray["_id"] as? String,
                let groupModulesArray = group["groupModules"] as? [Any],
                let usersArray = group["users"] as? [Any],
                let pendingUsersArray = group["pendingUsers"] as? [Any] else { return nil }
            let detail = group["detail"] as? String ?? ""
            let users = self.parseOtherUsers(from: usersArray)
            let pendingUsers = self.parseOtherUsers(from: pendingUsersArray)
            let groupModules = self.parseGroupModules(from: groupModulesArray)
            let groupType = GroupType.empty
            groupType.name = groupTypeName
            groupType.groupTypeId = groupTypeId
            return UserGroup(
                userGroupId: id,
                name: name,
                detail: detail,
                accessCode: accessCode,
                groupType: groupType,
                groupModules: groupModules,
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
                let moduleTypeArray = groupModule["moduleType"] as? [String:Any],
                let userGroup = groupModule["userGroup"] as? String,
                let moduleTypeId = moduleTypeArray["_id"] as? String,
                let moduleTypeBackgroundColor = moduleTypeArray["backgroundColor"] as? String,
                let moduleTypeAddButtonBackgroundColor = moduleTypeArray["addButtonBackgroundColor"] as? String,
                let moduleTypeAppVersion = moduleTypeArray["appVersion"] as? Int,
                let moduleTypeName = moduleTypeArray["name"] as? String,
                let moduleTypeDetail = moduleTypeArray["detail"] as? String,
                let revision = groupModule["revision"] as? Int else { return nil }
            let moduleType = ModuleType.empty
            moduleType.moduleTypeId = moduleTypeId
            moduleType.appVersion = moduleTypeAppVersion
            moduleType.name = moduleTypeName
            moduleType.detail = moduleTypeDetail
            moduleType.backgroundColor = moduleTypeBackgroundColor
            moduleType.addButtonBackgroundColor = moduleTypeAddButtonBackgroundColor
            return GroupModule(
                groupModuleId: id,
                userGroupId: userGroup,
                moduleType: moduleType,
                revision: revision
            )
        }
    }

    func parseGroupTypes(groupTypes: [Any], moduleTypes: [Any]) -> ([GroupType], [ModuleType]) {
        var moduleTypesParsed: [ModuleType] = []
        let groupTypes: [GroupType] = groupTypes.flatMap { groupType in
            guard
                let groupType = groupType as? [String:Any],
                let id = groupType["_id"] as? String,
                let name = groupType["name"] as? String,
                let detail = groupType["detail"] as? String,
                let logo = groupType["logo"] as? [String:Any],
                let logoDataObject = logo["data"] as? [String:Any],
                let logoDataArray = logoDataObject["data"] as? [Any],
                let moduleTypesArray = groupType["moduleTypes"] as? [Any] else {
                    return nil
            }
            moduleTypesParsed = moduleTypes.flatMap { moduleType in
                guard
                    let moduleType = moduleType as? [String:Any],
                    let id = moduleType["_id"] as? String,
                    let backgroundColor = moduleType["backgroundColor"] as? String,
                    let addButtonBackgroundColor = moduleType["addButtonBackgroundColor"] as? String,
                    let appVersion = moduleType["appVersion"] as? Int,
                    let name = moduleType["name"] as? String,
                    let logoObject = moduleType["logo"] as? [String:Any],
                    let logoDataObject = logoObject["data"] as? [String:Any],
                    let logo = logoDataObject["data"] as? [Any],
                    let detail = moduleType["detail"] as? String else {
                        return nil
                }
                let logoData = Data(bytes: logo as? [UInt8] ?? [])
                return ModuleType(
                    moduleTypeId: id,
                    name: name,
                    detail: detail,
                    image: logoData,
                    appVersion: appVersion,
                    backgroundColor: backgroundColor,
                    addButtonBackgroundColor: addButtonBackgroundColor
                )
            }
            let moduleTypesInGroup: [ModuleType] = moduleTypesParsed.flatMap { moduleType in
                for module in moduleTypesArray {
                    if let module = module as? String, module == moduleType.moduleTypeId {
                        return moduleType
                    }
                }
                return nil
            }
            let logoData = Data(bytes: logoDataArray as? [UInt8] ?? [])
            return GroupType(
                groupTypeId: id,
                name: name,
                detail: detail,
                logo: logoData,
                modules: moduleTypesInGroup
            )
        }
        return (groupTypes, moduleTypesParsed)
    }

}
