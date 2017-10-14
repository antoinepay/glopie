//
//  FriendRepository.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import Foundation
import FBSDKLoginKit

protocol FriendRepository {
    func fetchUserFriends()
}

protocol FriendViewContract: class {
    func userFriendsFetched(_ userFriends: [FacebookFriend])
    func handleUserFriendsError(_ error: HTTPError)
}

extension FriendViewContract {
    func userFriendsFetched(_ userFriends: [FacebookFriend]) {}
    func handleUserFriendsError(_ error: HTTPError) {}
}

class FriendRepositoryImplementation: FriendRepository {

    private var parser: JSONParserImplementation
    private var client: HTTPClient
    private var viewContract: FriendViewContract

    init(client: HTTPClient, parser: JSONParserImplementation, viewContract: FriendViewContract) {
        self.parser = parser
        self.client = client
        self.viewContract = viewContract
    }

    func fetchUserFriends() {
        let user = User.retrieveFromUserDefaults()
        fetchUserFriendsAction(from: user) { result in
            switch result {
            case let .value(facebookFriends):
                self.viewContract.userFriendsFetched(facebookFriends)
            case let .error(error):
                self.viewContract.handleUserFriendsError(error)
            }
        }
    }

    private func fetchUserFriendsAction(from user: User, callback: @escaping (Result<[FacebookFriend],HTTPError>) -> Void) {
        let request = FBSDKGraphRequest(
            graphPath: "me/friends",
            parameters: ["fields":"name, id"],
            tokenString: user.token,
            version: nil,
            httpMethod: "GET"
        )
        request?.start(completionHandler: { (connection, result, error) in
            guard
                let data = result as? [String:Any],
                let friendsArray = data["data"] as? [Any] else {
                callback(Result.error(HTTPError(type: .badParameters)))
                return
            }
            let facebookFriends = self.parser.parseFacebookFriends(friendsArray: friendsArray)
            callback(Result.value(facebookFriends))
        })
    }
}

