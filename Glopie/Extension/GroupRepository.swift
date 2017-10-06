//
//  GroupRepository.swift
//  Glopie
//
//  Created by Antoine Payan on 02/10/2017.
//
import Foundation

protocol GroupRepository {
    func fetchUserGroups()
    func fetchGroupTypes()
}

protocol GroupViewContract: class {
    func userGroupsFetched(_ userGroups: [UserGroup])
    func handleUserGroupsError(_ error: HTTPError)
    func groupTypesFetched(_ groupTypesModules: ([GroupType], [ModuleType]))
    func handleGroupTypesError(_ error: HTTPError)
}

extension GroupViewContract {
    func userGroupsFetched(_ userGroups: [UserGroup]) {}
    func handleUserGroupsError(_ error: HTTPError) {}
    func groupTypesFetched(_ groupTypesModules: ([GroupType], [ModuleType])) {}
    func handleGroupTypesError(_ error: HTTPError) {}
}

class GroupRepositoryImplementation: GroupRepository {

    private var parser: JSONParserImplementation
    private var client: HTTPClient
    private var viewContract: GroupViewContract

    init(client: HTTPClient, parser: JSONParserImplementation, viewContract: GroupViewContract) {
        self.parser = parser
        self.client = client
        self.viewContract = viewContract
    }

    func fetchUserGroups() {
        let user = User.retrieveFromUserDefaults()
        fetchUserGroupAction(from: user) { result in
            switch result {
            case let .value(userGroups) :
                self.viewContract.userGroupsFetched(userGroups)
            case let .error(error) :
                self.viewContract.handleUserGroupsError(error)
            }
        }
    }

    private func fetchUserGroupAction(from user: User, callback: @escaping (Result<[UserGroup],HTTPError>) -> Void) {
        let userAccess = ["email":user.email, "token":user.token, "appVersion":10] as [String : Any]
        do {
            let jsonUser = try JSONSerialization.data(withJSONObject: userAccess, options: .prettyPrinted)
            let jsonString = String(data: jsonUser, encoding: .utf8) ?? ""
            let requestAPI = HTTPRequest(
                .post,
                URL: TargetSettings.userGroup,
                parameters: ["user": jsonString],
                completion: { result in
                    switch result {
                    case let .value(json):
                        guard
                            let json = json as? [String:Any],
                            let data = json["data"] as? [Any] else {
                                let error = HTTPError(type: .unprocessableEntity)
                                callback(Result.error(error))
                                return
                        }
                        let userGroups = self.parser.parseUserGroups(groups: data)
                        callback(Result.value(userGroups))
                    case let .error(error):
                        callback(Result.error(error))
                    }})
                client.send(request: requestAPI)
        } catch _ as NSError {
            callback(Result.error(HTTPError(type: .badParameters)))
        }
    }

    func fetchGroupTypes() {
        let user = User.retrieveFromUserDefaults()
        fetchGroupTypesAction(from: user) { result in
            switch result {
            case let .value(groupTypes) :
                self.viewContract.groupTypesFetched(groupTypes)
            case let .error(error) :
                self.viewContract.handleGroupTypesError(error)
            }
        }
    }

    private func fetchGroupTypesAction(from user: User, callback: @escaping (Result<([GroupType], [ModuleType]), HTTPError>) -> Void) {
        let userAccess = ["email":user.email, "token":user.token, "appVersion":10] as [String : Any]
        do {
            let jsonUser = try JSONSerialization.data(withJSONObject: userAccess, options: .prettyPrinted)
            let jsonString = String(data: jsonUser, encoding: .utf8) ?? ""
            let requestAPI = HTTPRequest(
                .post,
                URL: TargetSettings.groupType,
                parameters: ["user": jsonString],
                completion: { result in
                    switch result {
                    case let .value(json):
                        guard
                            let json = json as? [String:Any],
                            let data = json["data"] as? [String:Any],
                            let groupTypesArray = data["groupTypes"] as? [Any],
                            let moduleTypesArray = data["moduleTypes"] as? [Any] else {
                                let error = HTTPError(type: .unprocessableEntity)
                                callback(Result.error(error))
                                return
                        }
                        let groupTypesModules = self.parser.parseGroupTypes(groupTypes: groupTypesArray, moduleTypes: moduleTypesArray)
                        callback(Result.value(groupTypesModules))
                    case let .error(error):
                        callback(Result.error(error))
                    }})
            client.send(request: requestAPI)
        } catch _ as NSError {
            callback(Result.error(HTTPError(type: .badParameters)))
        }
    }



}

