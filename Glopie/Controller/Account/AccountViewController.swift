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

class AccountViewController: SharedViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak private var picture: UIImageView!
    @IBOutlet weak private var tableView: UITableView!

    private var user: User?
    private var attributes: [AccountTableViewCellLabelViewModel] = []
    
    init(factory: Factory) {
        super.init(factory: factory, nibName: "AccountViewController")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User.retrieveFromUserDefaults()
        setupViewModel()
        setupView()
        setupNavigationBar()
    }
    
    // MARK : UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountLabelTableViewCell")! as? AccountLabelTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(model: attributes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(attributes[indexPath.row].rowHeight)
    }
    
    
    // MARK : Private
    
    private func setupView() {
        picture.backgroundColor = .black
        picture.layer.cornerRadius = 50
        picture.clipsToBounds = true
        picture.contentMode = .scaleAspectFill
        if let user = user {
            let url = URL(string: user.picture)
            if user.picture.isEmpty {
                picture.image = picture.image(with: user)
            }
            picture.sd_setShowActivityIndicatorView(true)
            picture.sd_setIndicatorStyle(.gray)
            picture.sd_setImage(
                with: url ?? URL(string: "#"),
                placeholderImage: picture.image(with: user),
                options: SDWebImageOptions.continueInBackground,
                completed: nil)
        }
        
        let nib = UINib(nibName: "AccountLabelTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AccountLabelTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        let rightItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = rightItem
        setupNavigationTitleView(with: "Profil")
    }
    
    private func setupViewModel() {
        attributes = [AccountTableViewCellLabelViewModel]()
        attributes.append(AccountTableViewCellLabelViewModel(labelText: "Firstname", labelTextColor: "1D1D26", labelFontName: "Avenir", labelFontSize: 11, rowHeight: 60, labelTextAlignment: NSTextAlignment.left.rawValue, valueText: (user?.firstname)!, valueTextColor: "1D1D26", valueFontName: "Avenir", valueFontSize: 16, valueTextAlignment: NSTextAlignment.left.rawValue))
        attributes.append(AccountTableViewCellLabelViewModel(labelText: "Lastname", labelTextColor: "1D1D26", labelFontName: "Avenir", labelFontSize: 11, rowHeight: 60, labelTextAlignment: NSTextAlignment.left.rawValue, valueText: (user?.lastname)!, valueTextColor: "1D1D26", valueFontName: "Avenir", valueFontSize: 16, valueTextAlignment: NSTextAlignment.left.rawValue))
        attributes.append(AccountTableViewCellLabelViewModel(labelText: "Email address", labelTextColor: "1D1D26", labelFontName: "Avenir", labelFontSize: 11, rowHeight: 60, labelTextAlignment: NSTextAlignment.left.rawValue, valueText: (user?.email)!, valueTextColor: "1D1D26", valueFontName: "Avenir", valueFontSize: 16, valueTextAlignment: NSTextAlignment.left.rawValue))
    }
    
    @objc private func logout() {
        FBSDKAccessToken.current() == nil ? GIDSignIn.sharedInstance().signOut() : FBSDKLoginManager().logOut()
        dismiss(animated: true)
    }
    
}
