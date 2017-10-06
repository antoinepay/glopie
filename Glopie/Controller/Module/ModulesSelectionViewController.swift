//
//  ModulesSelectionViewController.swift
//  Glopie
//
//  Created by Antoine Payan on 05/10/2017.
//

import UIKit

class ModulesSelectionViewController: SharedViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak private var validateButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!

    private let groupType: GroupType
    private let moduleTypes: [ModuleType]
    private var moduleTypesSelected: [ModuleType]
    private let reuseIdentifier = "ModuleSelectionTableViewCell"
    private var scrollViewOrigin = CGPoint.zero

    init(factory: Factory, groupType: GroupType, moduleTypes: [ModuleType]) {
        self.groupType = groupType
        self.moduleTypes = moduleTypes
        self.moduleTypesSelected = self.groupType.modules
        super.init(factory: factory, nibName: "ModulesSelectionViewController")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateCustomBackButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewOrigin = tableView.contentOffset
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateNavigationTitleView(from: scrollView, with: scrollViewOrigin)
    }

    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moduleTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ModuleSelectionTableViewCell {
            var selected = false
            for moduleSelected in moduleTypesSelected {
                if moduleTypes[indexPath.row].moduleTypeId == moduleSelected.moduleTypeId {
                    selected = true
                }
            }
            cell.setup(
                viewModel: ModuleTypeViewModelMapper.viewModel(moduleTypes[indexPath.row]),
                isModuleSelected: selected
            )
            return cell
        }
        return UITableViewCell()
    }

    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ModuleSelectionTableViewCell {
            let moduleType = moduleTypes[indexPath.row]
            var deleted = false
            moduleTypesSelected = moduleTypesSelected.flatMap { module in
                if module.moduleTypeId == moduleType.moduleTypeId {
                    deleted = true
                    return nil
                } else {
                    return module
                }
            }
            if !deleted {
                moduleTypesSelected.append(moduleType)
            }
        }
        updateModulesNumber()
    }
    @IBAction func validateModulesChoice(_ sender: UIButton) {
        let groupDetailViewController = GroupDetailViewController(factory: factory)
        navigationController?.pushViewController(groupDetailViewController, animated: true)
    }
    
    private func setupView() {
        var moduleText = String(moduleTypesSelected.count)
        moduleText += "/" + String(moduleTypes.count)
        moduleText += moduleTypesSelected.count > 1 ? " modules" : " module"
        setupNavigationTitleView(with: "Choix des modules\n" + moduleText, fontSize: 14)
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.tableFooterView = UIView()

        validateButton.backgroundColor = TargetSettings.secondColor
        validateButton.layer.cornerRadius = 5.0
        validateButton.layer.shadowColor = UIColor.black.cgColor
        validateButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        validateButton.layer.shadowRadius = 4.0
        validateButton.layer.shadowOpacity = 0.5
        validateButton.setTitle("VALIDER", for: .normal)
        validateButton.setTitleColor(.white, for: .normal)
    }

    private func updateModulesNumber() {
        var moduleText = String(moduleTypesSelected.count)
        moduleText += "/" + String(moduleTypes.count)
        moduleText += moduleTypesSelected.count > 1 ? " modules" : " module"
        setupNavigationTitleView(with: "Choix des modules\n" + moduleText, fontSize: 14)
    }


}
