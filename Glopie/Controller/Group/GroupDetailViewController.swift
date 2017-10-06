//
//  GroupDetailViewController.swift
//  Glopie
//
//  Created by Antoine Payan on 06/10/2017.
//

import UIKit

protocol GroupDetailHeaderViewDelegate: class {
    func addImageChoice()
}

class GroupDetailViewController: SharedViewController, UITableViewDataSource, UITableViewDelegate, GroupDetailHeaderViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak private var tableView: UITableView!

    private var viewModels: [GroupDetailTableViewCellViewModel] = []
    private var scrollViewOrigin = CGPoint.zero

    init(factory: Factory) {
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

    //MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let headerView = tableView.tableHeaderView as? GroupDetailHeaderView {
            headerView.configure(logo: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }

    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDetailTableViewCell", for: indexPath) as? GroupDetailTableViewCell {
            cell.configure(viewModel: viewModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    //MARK: - Private

    private func setup() {
        let headerView = GroupDetailHeaderView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.size.width, height: 160)), delegate: self)
        headerView.configure(logo: #imageLiteral(resourceName: "GlopieIcon"))
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "GroupDetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupDetailTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        setupNavigationTitleView(with: "Détails du groupe")
        updateCustomBackButton()
    }

    private func setupTableView() {
        let titleViewModel = GroupDetailTableViewCellViewModel(title: "Titre", valuePlaceholder: "Titre du groupe", value: "", editable: true)
        let descriptionViewModel = GroupDetailTableViewCellViewModel(title: "Description", valuePlaceholder: "Entrez une description", value: "", editable: true)
        let accessCodeViewModel = GroupDetailTableViewCellViewModel(title: "Lien de partage", valuePlaceholder: "", value: "Disponible une fois le groupe créé", editable: false)
        viewModels.append(contentsOf: [titleViewModel, descriptionViewModel, accessCodeViewModel])
        tableView.reloadData()
    }
}

