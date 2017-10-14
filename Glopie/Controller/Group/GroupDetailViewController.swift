//
//  GroupDetailViewController.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import UIKit
import FBSDKLoginKit
import SDWebImage

enum GroupDetailTextFieldsType {
    case name
    case detail
    case accessCode

    func title() -> String {
        switch self {
        case .name:
            return "name".localized()
        case .detail:
            return "detail".localized()
        case .accessCode:
            return "accessCode".localized()
        }
    }

    func isEditable() -> Bool {
        return self != .accessCode
    }

    func placeholder() -> String {
        switch self {
        case .name:
            return "namePlaceholder".localized()
        case .detail:
            return "detailPlaceholder".localized()
        case .accessCode:
            return "accessCodePlaceholder".localized()
        }
    }
}

protocol GroupDetailHeaderViewDelegate: class {
    func addImageChoice()
}

protocol GroupAddUsersDelegate: class {
    func addUsers(users: [FacebookFriend])
    func presentUsersList()
}

protocol GroupDetailTextEditDelegate: class {
    func textFieldDidChange(for type: GroupDetailTextFieldsType, with value: String)
}

class GroupDetailViewController:
    SharedViewController,
    UITableViewDataSource,
    UITableViewDelegate,
    GroupDetailHeaderViewDelegate,
    GroupAddUsersDelegate,
    GroupDetailTextEditDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{

    @IBOutlet weak private var validateButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!

    private var viewModels: [GroupDetailTableViewCellViewModel] = []
    private var scrollViewOrigin = CGPoint.zero
    private var userGroup: UserGroup
    private var facebookUsersPending: [FacebookFriend] = []

    init(factory: Factory) {
        self.userGroup = UserGroup()
        super.init(factory: factory, nibName: "GroupDetailViewController")
        view.addGestureRecognizer(dismissKeyboardTap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewOrigin = tableView.contentOffset
    }

    //MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateNavigationTitleView(from: scrollView, with: scrollViewOrigin)
    }

    //MARK: - GroupDetailHeaderViewDelegate

    func addImageChoice() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    //MARK: - GroupAddUsersDelegate

    func addUsers(users: [FacebookFriend]) {
        userGroup.usersPending = users.flatMap { facebookUser in
            let user = User()
            user.externalId = facebookUser.id
            user.picture = facebookUser.profilePictureLink
            user.logType = .facebook
            return user
        }
        facebookUsersPending = users
        tableView.reloadSections([1], with: .fade)
    }

    func presentUsersList() {
        let user = User.retrieveFromUserDefaults()
        if user.logType == .facebook {
            navigationController?.pushViewController(FriendsViewController(factory: factory, delegate: self), animated: true)
        }
    }

    //MARK: - GroupDetailTextEditDelegate

    func textFieldDidChange(for type: GroupDetailTextFieldsType, with value: String) {
        switch type {
        case .name:
            userGroup.name = value
        case .detail:
            userGroup.detail = value
        default:
            return
        }
    }

    //MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let headerView = tableView.tableHeaderView as? GroupDetailHeaderView {
            headerView.configure(logo: pickedImage)
            userGroup.image = pickedImage.sd_imageData(as: SDImageFormat.PNG) ?? Data()
        }
        dismiss(animated: true, completion: nil)
    }

    //MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModels.count
        case 1:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDetailTableViewCell", for: indexPath) as? GroupDetailTableViewCell {
                cell.configure(viewModel: viewModels[indexPath.row], delegate: self)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDetailUsersTableViewCell", for: indexPath) as? GroupDetailUsersTableViewCell {
                cell.setup(with: facebookUsersPending, delegate: self)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 160
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 1 ? UIView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.frame.size.width, height: 5))) : UIView()
    }

    //MARK: - Private

    private func setup() {
        let headerView = GroupDetailHeaderView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.size.width, height: 160)), delegate: self)
        headerView.configure(logo: #imageLiteral(resourceName: "GlopieIcon"))
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "GroupDetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupDetailTableViewCell")
        let nibUsers = UINib(nibName: "GroupDetailUsersTableViewCell", bundle: nil)
        tableView.register(nibUsers, forCellReuseIdentifier: "GroupDetailUsersTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        setupNavigationTitleView(with: "groupDetailsTitle".localized())
        updateCustomBackButton()

        validateButton.backgroundColor = TargetSettings.secondColor
        validateButton.layer.cornerRadius = 5.0
        validateButton.layer.shadowColor = UIColor.black.cgColor
        validateButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        validateButton.layer.shadowRadius = 4.0
        validateButton.layer.shadowOpacity = 0.5
        validateButton.setTitle("validate".localized().uppercased(), for: .normal)
        validateButton.setTitleColor(.white, for: .normal)
    }

    private func setupTableView() {
        let titleViewModel = GroupDetailTableViewCellViewModel(value: "", type: .name)
        let descriptionViewModel = GroupDetailTableViewCellViewModel(value: "", type: .detail)
        let accessCodeViewModel = GroupDetailTableViewCellViewModel(value: "accessCodePlaceholder".localized(), type: .accessCode)
        viewModels.append(contentsOf: [titleViewModel, descriptionViewModel, accessCodeViewModel])
        tableView.reloadData()
    }
    
    @IBAction private func validateAction(_ sender: UIButton) {
        
    }
}

