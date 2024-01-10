//
//  HomeCollectionViewCell.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier = "HomeCollectionViewCell"

    private let plate: PlateView = {
        let plate = PlateView()
        return plate
    }()
    
    private let flagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "flag")
        return image
    }()
    
    private let azLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "AZ"
        label.font = UIFont.boldSystemFont(ofSize: 8)
        return label
    }()
    
    private let plateNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let plateOwner: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let platePrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .white
        label.backgroundColor = .systemBlue
        
        return label
    }()
    
    private let addToFavBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        
        
        contentView.backgroundColor = .white
        
        configureShadow()
        
        contentView.addSubview(plate)
        plate.configureSmall()
        
        contentView.addSubview(plateOwner)
        contentView.addSubview(platePrice)
//        contentView.addSubview(addToFavBtn)
        
        plate.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15, height: 35)
        
        
        plateOwner.anchor(top: plate.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 10)
    
        
        platePrice.anchor(top: plateOwner.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 60)
        
//        addToFavBtn.anchor(bottom: platePrice.bottomAnchor, right: contentView.rightAnchor, paddingRight: 10, width: 30, height: 30)
        
    }
    
    func configureShadow() {
        contentView.layer.cornerRadius = 5
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    public func configureCell(with item: CarPlate) {
        plate.plateNumber.text = item.plateSeries + "-" + item.plateFirstChar + item.plateSecondChar + "-" + item.plateEnding
        plate.plateNumber.font = UIFont(name: "Matricula Espanola", size: 30)
        plateOwner.text = item.owner
        platePrice.text = String(item.price) + " ₼"
    }
    
}
