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

class AccountViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak private var picture: UIImageView!
    @IBOutlet weak private var addImage: UIButton!
    @IBOutlet weak private var tableView: UITableView!
    
    init() {
        super.init(nibName: "AccountViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : Private
    
    private func setupView() {
        picture.backgroundColor = .black
        picture.layer.cornerRadius = 40
        picture.clipsToBounds = true
        
        addImage.setImage(UIImage.fontAwesomeIcon(name: .plus, textColor: .white, size: CGSize(width: 20, height: 20)), for: .normal)
        addImage.tintColor = .white
        addImage.setTitle("", for: .normal)
        addImage.setBackgroundColor(UIColor(hexString: "50D2C2"), forState: .normal)
        addImage.layer.cornerRadius = 12.5
        addImage.clipsToBounds = true
    }
    
    private func setupNavigationBar() {
        let rightItemImage = UIImage(named: "logout")
        let rightItem = UIBarButtonItem(image: rightItemImage, style: .plain, target: self, action: #selector(logout))
        rightItem.tintColor = UIColor(hexString: "FF7F7F")
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc private func logout() {
        FBSDKAccessToken.current() == nil ? GIDSignIn.sharedInstance().signOut() : FBSDKLoginManager().logOut()
        dismiss(animated: true)
    }
    
}
