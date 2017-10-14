//
//  FriendsViewController.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import UIKit

class FriendsViewController: SharedViewController, UITableViewDataSource, UITableViewDelegate, FriendViewContract {

    @IBOutlet weak private var validateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var viewModels: [FriendTableViewCellViewModel] = []
    private var facebookFriends: [FacebookFriend] = []
    lazy private var friendRepository: FriendRepository = self.factory.getFriendRepository(viewContract: self)

    weak var delegate: GroupAddUsersDelegate?

    private var usersSelected: [FacebookFriend] = []

    init(factory: Factory, delegate: GroupAddUsersDelegate) {
        self.delegate = delegate
        super.init(factory: factory, nibName: "FriendsViewController")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        friendRepository.fetchUserFriends()
    }

    func userFriendsFetched(_ userFriends: [FacebookFriend]) {
        self.facebookFriends = userFriends
        viewModels = FriendTableViewCellViewModelMapper.viewModels(userFriends)
        tableView.reloadData()
    }

    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as? FriendTableViewCell {
            cell.setup(viewModel: viewModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userAtIndexPath = facebookFriends[indexPath.row]
        usersSelected.append(userAtIndexPath)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let userAtIndexPath = facebookFriends[indexPath.row]
        usersSelected = usersSelected.flatMap { user in
            return user.id == userAtIndexPath.id ? nil : user
        }
    }

    //Mark: - Private

    @IBAction func validateAction(_ sender: UIButton) {
        delegate?.addUsers(users: usersSelected)
        _ = navigationController?.popViewController(animated: true)
    }

    private func setup() {
        let nib = UINib(nibName: "FriendTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FriendTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        setupNavigationTitleView(with: "Ajouter des amis au groupe")
        tableView.tableFooterView = UIView()
        updateCustomBackButton()

        validateButton.backgroundColor = TargetSettings.secondColor
        validateButton.layer.cornerRadius = 5.0
        validateButton.layer.shadowColor = UIColor.black.cgColor
        validateButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        validateButton.layer.shadowRadius = 4.0
        validateButton.layer.shadowOpacity = 0.5
        validateButton.setTitle("VALIDER", for: .normal)
        validateButton.setTitleColor(.white, for: .normal)
    }
}
