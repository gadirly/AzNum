//
//  HomeViewController.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import UIKit



class HomeViewController: UIViewController {
    
    // MARK: Properties

    var viewModel = PlateViewModel()
    var refreshController = UIRefreshControl()
    
    
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateUI()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainCollectionView.frame = view.bounds
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        title = "AzNum"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(handleSearchBtn))
        navigationItem.rightBarButtonItem?.tintColor = .label
        
        view.addSubview(mainCollectionView)
        mainCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        mainCollectionView.addSubview(refreshController)
        refreshController.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
    }
    
    public func updateUI() {
    
        viewModel.fetchAllItems { [weak self] in
            self?.mainCollectionView.reloadData()
        }
    }
    
    // MARK: Actions
    
    @objc private func refreshCollection() {
        viewModel.fetchAllItems { [weak self] in
            self?.mainCollectionView.reloadData()
            self?.refreshController.endRefreshing()
        }
    }
    
    @objc private func handleSearchBtn() {
        let vc = SearchViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

// MARK: Extensions

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(with: viewModel.items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlate = viewModel.items[indexPath.row]
        let vc = PlateDetailsViewController()
        vc.configureView(plate: selectedPlate)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        
        return CGSize(width: (width/2)-20, height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.bounds.width, height: 50)
    }
}


// MARK: LoginDelegate

