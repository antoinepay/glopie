//
//  LoginViewController.swift
//  Glopie
//
//  Created by Antoine Payan on 27/09/2017.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import GoogleSignIn

private struct Constants {
    static let readPermissions = ["public_profile", "email", "user_friends"]
    static let fields = ["fields":"email,first_name,last_name, picture.type(large)"]
}

class LoginViewController: UIViewController, GIDSignInUIDelegate, LoginViewContract, GIDSignInDelegate {

    @IBOutlet weak private var googleSignInButton: GIDSignInButton!
    @IBOutlet weak private var profilePictureImageView: UIImageView!
    @IBOutlet weak private var facebookButton: FBSDKLoginButton!

    private let factory: Factory
    lazy private var loginRepository = self.factory.getLoginRepository(viewContract: self)

    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: "LoginViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    //MARK: - LoginViewContract

    func facebookToken(_ user: User) {
        User.saveToUserDefaults(user)
    }

    func handleFacebookTokenError(_ error: HTTPError) {
        User.eraseUserFromUserDefaults()
    }


    func googleSignInAPI(_ user: User) {
        User.saveToUserDefaults(user)
    }

    func handleGoogleSignInAPIError(_ error: HTTPError) {
        User.eraseUserFromUserDefaults()
    }

    //MARK: - GIDSignInDelegate

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let userGG = user  else {
            User.eraseUserFromUserDefaults()
            return
        }
        let user = User(
            externalId: userGG.userID,
            firstname: userGG.profile.givenName,
            lastname: userGG.profile.familyName,
            email: userGG.profile.email,
            token: userGG.authentication.accessToken,
            logType: .google
        )
        loginRepository.googleSignIn(user: user)
    }

    //MARK: - Private

    private func setupView() {
        googleSignInButton.style = .iconOnly
        googleSignInButton.colorScheme = .dark
        facebookButton.addTarget(self, action: #selector(loginFacebook(_:)), for: .touchUpInside)
    }

    @objc private func loginFacebook(_ sender: Any) {
        if FBSDKAccessToken.current() == nil {
            let readPermissions = Constants.readPermissions
            FBSDKLoginManager().logIn(
                withReadPermissions: readPermissions,
                from: self,
                handler: { (result, error) in
                    if let token = FBSDKAccessToken.current() {
                        self.loginRepository.facebookGraphRequest(
                            token: token.tokenString,
                            parameters: Constants.fields
                        )
                    }
            })
        }
    }

    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }

    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        dismiss(animated: true, completion: nil)
    }

}

