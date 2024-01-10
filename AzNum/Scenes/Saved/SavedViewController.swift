//
//  SavedViewController.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import UIKit

class SavedViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = PlateViewModel()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainCollectionView.frame = view.bounds
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        title = "Seçilmişlər"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        view.addSubview(mainCollectionView)
        mainCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
    }
    
    func refreshUI() {
        viewModel.getFavorites {
            self.mainCollectionView.reloadData()
        }
    }

}

// MARK: Extensions

extension SavedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlate = viewModel.items[indexPath.row]
        let vc = PlateDetailsViewController()
        vc.configureView(plate: selectedPlate)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension SavedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        
        return CGSize(width: (width/2)-20, height: 105)
    }

}
