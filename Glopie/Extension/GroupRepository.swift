//
//  GroupRepository.swift
//  Glopie
//
//  Created by Antoine Payan on 02/10/2017.
//
import Foundation

protocol GroupRepository {
    func fetchUserGroup()
}

protocol GroupViewContract: class {
    func userGroupsFetched(_ userGroups: [UserGroup])
    func handleUserGroupsError(_ error: HTTPError)
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

    func fetchUserGroup() {

    }

    private func fetchUserGroupAction(from user: User, callback: @escaping (Result<[UserGroup],HTTPError>) -> Void) {
        let userAccess = ["email":user.email, "token":user.token, "appVersion":10] as [String : Any]
        let jsonEncoder = JSONEncoder()
        let jsonUser = try? jsonEncoder.encode(userAccess)
        let requestAPI = HTTPRequest(
            .post,
            URL: TargetSettings.userGroup,
            parameters: ["userAccess": jsonUser],
            completion: { result in
            switch result {
            case let .value(json):
                guard
                    let json = json as? [String:Any],
                    let data = json["data"] as? [Any] else {
                        let error = HTTPError(type: .unprocessableEntity)
                        self.viewContract.handleUserGroupsError(error)
                        return
                }
                let userGroups = self.parser.parseUserGroups(groups: data)
                self.viewContract.userGroupsFetched(userGroups)
            case let .error(error):
                self.viewContract.handleUserGroupsError(error)
            }})
        client.send(request: requestAPI)
    }



}

