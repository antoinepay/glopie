//
//  LoginRepository.swift
//  Glopie
//
//  Created by Antoine Payan on 27/09/2017.
//
import FBSDKLoginKit

protocol LoginRepository {
    func facebookGraphRequest(token: String, parameters: [String:String])
    func googleSignIn(user: User)
}

protocol LoginViewContract: class {
    func facebookToken(_ user: User)
    func handleFacebookTokenError(_ error: HTTPError)
    func googleSignInAPI(_ user: User)
    func handleGoogleSignInAPIError(_ error: HTTPError)
}

class LoginRepositoryImplementation: LoginRepository {

    private var parser: JSONParserImplementation
    private var client: HTTPClient
    private var viewContract: LoginViewContract

    init(client: HTTPClient, parser: JSONParserImplementation, viewContract: LoginViewContract) {
        self.parser = parser
        self.client = client
        self.viewContract = viewContract
    }

    func facebookGraphRequest(token: String, parameters: [String:String]) {
        let request = FBSDKGraphRequest(
            graphPath: "me",
            parameters: parameters,
            tokenString: token,
            version: nil,
            httpMethod: "GET"
            )
        facebookGraphRequestAction(request: request) { result in
            switch result {
            case let .value(value):
                let jsonEncoder = JSONEncoder()
                let userData = try? jsonEncoder.encode(value)
                let userString = String(data: userData!, encoding: .utf8)
                let requestAPI = HTTPRequest(.post, URL: TargetSettings.authenticate, parameters: ["user": userString!], completion: { result in
                    switch result {
                    case let .value(json):
                        guard
                            let json = json as? [String:Any],
                            let data = json["data"] as? [String:Any] else {
                                let error = HTTPError(type: .unprocessableEntity)
                                self.viewContract.handleFacebookTokenError(error)
                                return
                        }
                        let user = self.parser.parseAPIResponse(user: data, from: .facebook)
                        self.viewContract.facebookToken(user)
                    case let .error(error):
                        self.viewContract.handleFacebookTokenError(error)
                    }})
                self.client.send(request: requestAPI)
            case let .error(error):
                self.viewContract.handleFacebookTokenError(error)
            }
        }
    }

    func googleSignIn(user: User) {
        let jsonEncoder = JSONEncoder()
        let userData = try? jsonEncoder.encode(user)
        let userString = String(data: userData!, encoding: .utf8)
        let request = HTTPRequest(.post, URL: TargetSettings.authenticate, parameters: ["user": userString!], completion: { result in
            switch result {
            case let .value(json):
                guard
                    let json = json as? [String:Any],
                    let data = json["data"] as? [String:Any] else {
                        let error = HTTPError(type: .unprocessableEntity)
                        self.viewContract.handleFacebookTokenError(error)
                        return
                }
                let user = self.parser.parseAPIResponse(user: data, from: .google)
                self.viewContract.googleSignInAPI(user)
            case let .error(error):
                self.viewContract.handleGoogleSignInAPIError(error)
            }})
        client.send(request: request)
    }

    private func facebookGraphRequestAction(request: FBSDKGraphRequest?, callback: @escaping (Result<User, HTTPError>) -> Void) {
        request?.start { _, result, error in
            if error != nil {
                callback(Result.error(HTTPError(type: .unspecified)))
            }
            guard let result = result as? [String:Any] else {
                callback(Result.error(HTTPError(type: .unprocessableEntity)))
                return
            }
            let user = self.parser.parseFacebookResponse(user: result, from: .facebook)
            callback(Result.value(user))
        }
    }


}
