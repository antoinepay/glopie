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

    @IBOutlet weak private var profilePictureImageView: UIImageView!
    @IBOutlet weak private var googleSignInButton: UIButton!
    @IBOutlet weak private var facebookButton: UIButton!
    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var glopieImage: UIImageView!
    

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.frame = view.frame
        backgroundGradient.colors = [UIColor(hexString: "F45C43").cgColor, UIColor(hexString: "EB3349").cgColor]
        stackView.layer.insertSublayer(backgroundGradient, at: 0)
        if GIDSignIn.sharedInstance().currentUser != nil || FBSDKAccessToken.current() != nil {
            presentHome(animated: false)
        }
    }

    //MARK: - LoginViewContract

    func facebookToken(_ user: User) {
        User.eraseUserFromUserDefaults()
        User.saveToUserDefaults(user)
        presentHome(animated: true)
    }

    func handleFacebookTokenError(_ error: HTTPError) {
        User.eraseUserFromUserDefaults()
    }


    func googleSignInAPI(_ user: User) {
        User.eraseUserFromUserDefaults()
        User.saveToUserDefaults(user)
        presentHome(animated: true)
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
            logType: .google,
            picture: userGG.profile.imageURL(withDimension: 128).absoluteString
        )
        loginRepository.googleSignIn(user: user)
    }

    //MARK: - Private

    private func setupView() {
        glopieImage.image = UIImage(named: "GlopieIcon.png")
        
        googleSignInButton.setTitle("Continue with google", for: .normal)
        googleSignInButton.setTitleColor(UIColor(hexString: "555555"), for: .normal)
        googleSignInButton.titleLabel?.font = UIFont(name: "Avenie", size: 15.0)
        googleSignInButton.backgroundColor = .white
        googleSignInButton.layer.cornerRadius = 4
        googleSignInButton.setImage(UIImage(named: "googleIcon"), for: UIControlState.normal)
        googleSignInButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        googleSignInButton.addTarget(self, action: #selector(loginGoogle(_:)), for: .touchUpInside)
        googleSignInButton.clipsToBounds = true
        
        facebookButton.setTitle("continueWithFB".localized(), for: .normal)
        facebookButton.setTitleColor(.white, for: .normal)
        facebookButton.titleLabel?.font = UIFont(name: "Avenie", size: 15.0)
        facebookButton.backgroundColor = UIColor(hexString: "3C5193")
        facebookButton.layer.cornerRadius = 4
        facebookButton.setImage(UIImage(named: "facebookIcon"), for: UIControlState.normal)
        facebookButton.tintColor = .white
        facebookButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        facebookButton.addTarget(self, action: #selector(loginFacebook(_:)), for: .touchUpInside)
        facebookButton.clipsToBounds = true
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

    @objc private func loginGoogle(_ sender: Any) {
        if GIDSignIn.sharedInstance().currentUser == nil {
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
    private func presentHome(animated: Bool) {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalTransitionStyle = .flipHorizontal
        present(mainTabBarController, animated: true)
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

