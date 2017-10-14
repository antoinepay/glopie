//
//  GroupsViewController.swift
//  Glopie
//
//  Created by Luc on 29/09/2017.
//

import UIKit
import Alamofire

class GroupsViewController: SharedViewController, UITableViewDelegate, UITableViewDataSource, GroupViewContract, FriendViewContract {

    @IBOutlet weak private var tableView: UITableView!

    private var user: User?
    private var groups: [GroupsTableViewCellViewModel] = []

    lazy private var groupRepository: GroupRepository = self.factory.getGroupRepository(viewContract: self)

    init(factory: Factory) {
        super.init(factory: factory, nibName: "GroupsViewController")
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPlaceholder(true)
        groupRepository.fetchUserGroups()
        factory.getFriendRepository(viewContract: self).fetchUserFriends()
    }


    //MARK: - GroupViewContract

    func userGroupsFetched(_ userGroups: [UserGroup]) {
        groups = GroupsTableViewCellViewModelMapper.viewModels(from: userGroups)
        setPlaceholder(false)
        tableView.reloadData()
    }

    func handleUserGroupsError(_ error: HTTPError) {
        setPlaceholder(false)
        print(error)
    }
    
    // MARK : UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell")! as? GroupsTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(model: groups[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(groups[indexPath.row].rowHeight)
    }
    
    // MARK : Private
    
    private func setupView() {
        let nib = UINib(nibName: "GroupsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupsTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    private func setupNavigationBar() {
        setupNavigationTitleView(with: "Mes groupes")
    }

}
