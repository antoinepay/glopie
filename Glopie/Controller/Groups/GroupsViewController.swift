//
//  GroupsViewController.swift
//  Glopie
//
//  Created by Luc on 29/09/2017.
//

import UIKit
import Alamofire

class GroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GroupViewContract {

    @IBOutlet weak private var tableView: UITableView!

    private let factory: Factory
    private var user: User?
    private var groups: [GroupsTableViewCellViewModel] = []

    lazy private var groupRepository: GroupRepository = self.factory.getGroupRepository(viewContract: self)

    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupRepository.fetchUserGroups()
        groupRepository.fetchGroupTypes()
    }

    //MARK: - GroupViewContract

    func userGroupsFetched(_ userGroups: [UserGroup]) {
        groups = GroupsTableViewCellViewModelMapper.viewModels(from: userGroups)
        tableView.reloadData()
    }

    func handleUserGroupsError(_ error: HTTPError) {
        print(error)
    }

    func groupTypesFetched(_ groupTypes: [GroupType]) {
        print("groupTypesFetched")
    }

    func handleGroupTypesError(_ error: HTTPError) {
        print(error)
    }
    
    // MARK : UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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

    }
    
    private func setupViewModel() {
        /*groups.append(GroupsTableViewCellViewModel(rowHeight: 80.0, labelsFontName: "Avenir", labelsTextAlignment: NSTextAlignment.left.rawValue, userImages: [], userImagesHeight: 50, userImagesShift: 5, groupNameText: "Group name", groupNameTextSize: 16.0, groupNameTextColor: "1D1D26", groupDetailText: "This is the group detail", groupDetailTextSize: 13.0, groupDetailTextColor: "1D1D26", groupTypeText: " Working group ", groupTypeTextSize: 9.0, groupTypeTextColor: "AA0000", groupTypeBorderColor: "AA0000", groupTypeBorderWidth: 1.0))*/
    }

}
