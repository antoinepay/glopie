//
//  Factory.swift
//  Helmee
//
//  Created by Antoine Payan on 11/06/2017.
//  Copyright © 2017 Antoine Payan. All rights reserved.
//

import Foundation

class Factory {
    
    private lazy var client = HTTPClient()
    private lazy var parser = JSONParserImplementation()

    func getLoginRepository(viewContract: LoginViewContract) -> LoginRepository {
        return LoginRepositoryImplementation(
            client: client,
            parser: parser,
            viewContract: viewContract
        )
    }

    func getGroupRepository(viewContract: GroupViewContract) -> GroupRepository {
        return GroupRepositoryImplementation(
            client: client,
            parser: parser,
            viewContract: viewContract
        )
    }

    func getFriendRepository(viewContract: FriendViewContract) -> FriendRepository {
        return FriendRepositoryImplementation(
            client: client,
            parser: parser,
            viewContract: viewContract
        )
    }
}
