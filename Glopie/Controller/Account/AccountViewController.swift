//
//  AccountViewController.swift
//  Glopie
//
//  Created by Luc on 30/09/2017.
//

import UIKit
import FontAwesome_swift
import GoogleSignIn
import FBSDKLoginKit
import SDWebImage

class AccountViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak private var picture: UIImageView!
    @IBOutlet weak private var addImage: UIButton!
    @IBOutlet weak private var tableView: UITableView!

    private var user: User?
    
    init() {
        super.init(nibName: "AccountViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User.retrieveFromUserDefaults()
        setupView()
        setupNavigationBar()
    }
    
    // MARK : Private
    
    private func setupView() {
        picture.backgroundColor = .black
        picture.layer.cornerRadius = 40
        picture.clipsToBounds = true
        picture.contentMode = .scaleAspectFill
        if let user = user {
            let url = URL(string: user.picture)
            let placeholder = UIImage.createInitialImage(from: user, with: CGSize(width: 80, height: 80))
            picture.image = placeholder
            picture.sd_setShowActivityIndicatorView(true)
            picture.sd_setIndicatorStyle(.gray)
            //picture.sd_setImage(with: url ?? URL(string: "#"), placeholderImage: placeholder, options: SDWebImageOptions.continueInBackground, completed: nil)
        }

        addImage.setImage(UIImage.fontAwesomeIcon(name: .plus, textColor: .white, size: CGSize(width: 20, height: 20)), for: .normal)
        addImage.tintColor = .white
        addImage.setTitle("", for: .normal)
        addImage.setBackgroundColor(UIColor(hexString: "50D2C2"), forState: .normal)
        addImage.layer.cornerRadius = 12.5
        addImage.clipsToBounds = true
    }
    
    private func setupNavigationBar() {
        let rightItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc private func logout() {
        FBSDKAccessToken.current() == nil ? GIDSignIn.sharedInstance().signOut() : FBSDKLoginManager().logOut()
        dismiss(animated: true)
    }
    
}
