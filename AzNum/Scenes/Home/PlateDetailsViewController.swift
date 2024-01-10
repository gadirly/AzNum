//
//  Plate2Controller.swift
//  AzNum
//
//  Created by Babek Gadirli on 06.12.23.
//

import UIKit

class PlateDetailsViewController: UIViewController {
    
    var viewModel: PlateViewModel = PlateViewModel()

    // MARK: Properties
    
    var isFavorite = false
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .light) // Feedback generator
    var plate: CarPlate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let plateView: PlateView = {
        var plateView = PlateView()
        
        return plateView
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let ownerLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .systemGray

        return label
    }()
    
    private let priceLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .systemBlue

        return label
    }()
    
    private let descriptionFormCard: CustomCardView = {
        let view = CustomCardView()
        view.setTitleText(text: "Əlavə məlumat")
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        
        return label
    }()
    
    private let phoneNumberFormCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        view.dropShadow()
        
        return view
    }()
    
    private let phoneIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "phone.fill")
        imageView.tintColor = .white
        
        return imageView
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    private let callLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Zəng et"
        
        return label
    }()
    
    private let addToFavBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.circle"), for: .normal)
        button.tintColor = .systemBlue
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.clipsToBounds = false
        button.backgroundColor = .white
        
        return button
    }()
    
    private let relatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "Bənzər elanlar"
        
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureRelatedSections()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addToFavBtn.layer.cornerRadius = addToFavBtn.frame.width/2
    }
    
    private func configureUI() {
        
        title = "Ətraflı"
        view.backgroundColor = .systemBackground

        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        
        scrollView.addSubview(plateView)
        plateView.configureBig()
        plateView.anchor(top: scrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 80)
        
        scrollView.addSubview(dividerLine)
        dividerLine.anchor(top: plateView.bottomAnchor, left: plateView.leftAnchor, right: plateView.rightAnchor, paddingTop: 20, height: 0.5 )
        
        scrollView.addSubview(ownerLabel)
        ownerLabel.anchor(top: dividerLine.bottomAnchor, left: plateView.leftAnchor, paddingTop: 12)
        
        scrollView.addSubview(priceLabel)
        priceLabel.anchor(top: dividerLine.bottomAnchor, right: plateView.rightAnchor, paddingTop: 12)
        
        descriptionFormCard.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: descriptionFormCard.topAnchor, left: descriptionFormCard.leftAnchor, right: descriptionFormCard.rightAnchor, paddingTop: 35, paddingLeft: 10, paddingRight: 6)
        
        scrollView.addSubview(descriptionFormCard)
        descriptionFormCard.anchor(top: priceLabel.bottomAnchor, left: view.leftAnchor, bottom: descriptionLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 10, paddingBottom: -20, paddingRight: 10)
        
        scrollView.addSubview(phoneNumberFormCard)
        phoneNumberFormCard.anchor(top: descriptionFormCard.bottomAnchor, left: descriptionFormCard.leftAnchor, right: descriptionFormCard.rightAnchor, paddingTop: 12, height: 40)
        
        phoneNumberFormCard.addSubview(phoneIcon)
        phoneIcon.anchor(top: phoneNumberFormCard.topAnchor, left: phoneNumberFormCard.leftAnchor, bottom: phoneNumberFormCard.bottomAnchor, paddingTop: 7, paddingLeft: 15, paddingBottom: 7)
        
        phoneNumberFormCard.addSubview(phoneLabel)
        phoneLabel.anchor(top: phoneNumberFormCard.topAnchor, left: phoneIcon.rightAnchor, bottom: phoneNumberFormCard.bottomAnchor, paddingLeft: 10)
        phoneNumberFormCard.addSubview(callLabel)
        callLabel.anchor(top: phoneNumberFormCard.topAnchor, bottom: phoneNumberFormCard.bottomAnchor, right: phoneNumberFormCard.rightAnchor, paddingRight: 10)
        
        plateView.addSubview(addToFavBtn)
        addToFavBtn.anchor(bottom: plateView.bottomAnchor, right: plateView.rightAnchor, paddingBottom: -16, paddingRight: 10, width: 43, height: 38)
        addToFavBtn.addTarget(self, action: #selector(addToFavClicked), for: .touchUpInside)
        
        view.addSubview(relatedLabel)
        relatedLabel.anchor(top: phoneNumberFormCard.bottomAnchor, left: phoneNumberFormCard.leftAnchor, paddingTop: 15)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.anchor(top: relatedLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 150)
        
        
    }
   
    func configureView(plate: CarPlate) {
        self.plate = plate
        plateView.plateNumber.text = plate.plateSeries + "-" + plate.plateFirstChar + plate.plateSecondChar + "-" + plate.plateEnding
        plateView.plateNumber.font = UIFont(name: "Matricula Espanola", size: 55)
        ownerLabel.text = plate.owner
        priceLabel.text = plate.price + " ₼"
        phoneLabel.text = plate.phoneNumber
        
        if plate.description != "" {
            descriptionLabel.text = plate.description
                    
        } else {
            descriptionLabel.text = "Məlumat yoxdur."
            descriptionLabel.textColor = .systemGray
        }
        
        viewModel.checkIfIsFavorite(itemID: plate.id) { [weak self] isFavorite in
            self?.isFavorite = isFavorite ? true : false
            let heartIconName = isFavorite ? "heart.fill" : "heart"
            let heartIcon = UIImage(systemName: heartIconName)
            self?.addToFavBtn.setImage(heartIcon, for: .normal)
        }
    }
    
    private func configureRelatedSections() {
        guard let plate = self.plate else {
            return
        }
        viewModel.getRelatedPlates(plate: plate) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: Actions
    
    @objc func addToFavClicked() {
        
        guard let plate = self.plate else {
            return
        }
        
        if isFavorite {
            viewModel.removeFromFavorites(itemID: plate.id) { _ in
                
            }
        } else {
            viewModel.addToFavorites(itemID: plate.id) { _ in
                
            }
        }
        
        isFavorite.toggle()
        let heartIconName = isFavorite ? "heart.fill" : "heart"
        let heartIcon = UIImage(systemName: heartIconName)
        addToFavBtn.setImage(heartIcon, for: .normal)
        
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }

}

// MARK: CollectionView Delegate and Datasource
extension PlateDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        
        let item = viewModel.items[indexPath.row]
            
        cell.configureCell(with: item)
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlate = viewModel.items[indexPath.row]
        let vc = PlateDetailsViewController()
        vc.configureView(plate: selectedPlate)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PlateDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        
        return CGSize(width: (width/2)-25, height: 105)
    }
    
   
}
