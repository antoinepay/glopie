//
//  GroupTypeSelectionCollectionViewController.swift
//  Glopie
//
//  Created by Antoine Payan on 05/10/2017.
//

import UIKit

private let reuseIdentifier = "GroupTypeCollectionViewCell"

class GroupTypeSelectionViewController: SharedViewController,
GroupViewContract,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak private var collectionView: UICollectionView!

    private var groupTypes: [GroupType] = []
    private var viewModels: [GroupTypeViewModel] = []
    private var allModuleTypes : [ModuleType] = []
    private var collectionViewOrigin: CGPoint = .zero
    lazy private var groupRepository: GroupRepository = self.factory.getGroupRepository(viewContract: self)

    init(factory: Factory) {
        super.init(factory: factory, nibName: "GroupTypeSelectionViewController")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupRepository.fetchGroupTypes()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setPlaceholder(true)
        collectionViewOrigin = collectionView.contentOffset
    }

    //MARK: - GroupViewContract

    func groupTypesFetched(_ groupTypesModules: ([GroupType], [ModuleType])) {
        viewModels = GroupTypeViewModelMapper.viewModels(from: groupTypesModules.0)
        allModuleTypes = groupTypesModules.1
        groupTypes = groupTypesModules.0
        setPlaceholder(false)
        collectionView.reloadData()
    }

    func handleGroupTypesError(_ error: HTTPError) {
        setPlaceholder(false)
        print(error)
    }

    //MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateNavigationTitleView(from: scrollView, with: collectionViewOrigin)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GroupTypeCollectionViewCell {
            cell.setup(viewModel: viewModels[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    //MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modulesSelectionViewController = ModulesSelectionViewController(
            factory: factory,
            groupType: groupTypes[indexPath.row],
            moduleTypes: allModuleTypes
        )
        navigationController?.pushViewController(modulesSelectionViewController, animated: true)
    }

    //MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width / 2.0
        return CGSize(width: width, height: width)
    }


    //MARK: - Private

    private func setup() {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        setupNavigationTitleView(with: "Choisir un type de groupe")

    }

    
}
