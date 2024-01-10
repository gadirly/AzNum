//
//  PlateView.swift
//  AzNum
//
//  Created by Babek Gadirli on 16.11.23.
//

import UIKit

class PlateView: UIView {
    
    private let plate: UIView = {
        let plate = UIView()
        plate.backgroundColor = .white
        plate.layer.masksToBounds = true
        plate.layer.cornerRadius = 5
        plate.layer.borderWidth = 0.2
        return plate
    }()
    
    let flagImage: UIImageView = {
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
    
    let plateNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    func configureSmall() {
        addSubview(plate)
        plate.addSubview(plateNumber)
        plate.addSubview(flagImage)
        plate.addSubview(azLabel)
        
        plate.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        plateNumber.anchor(top: plate.topAnchor, left: plate.leftAnchor, bottom: plate.bottomAnchor, right: plate.rightAnchor, paddingLeft: 30, paddingRight: 10)
        
        flagImage.anchor(top: plate.topAnchor, left: plate.leftAnchor, bottom: plate.bottomAnchor, right: plateNumber.leftAnchor, paddingTop: 7, paddingLeft: 10, paddingBottom: 20, paddingRight: 10)
        
        
        azLabel.anchor(top: flagImage.bottomAnchor, paddingTop: 3)
        azLabel.centerX(inView: flagImage)
    }
    
    func configureBig() {
        addSubview(plate)
        plate.addSubview(plateNumber)
        plate.addSubview(flagImage)
        plate.addSubview(azLabel)
        
        plate.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        plateNumber.anchor(top: plate.topAnchor, left: plate.leftAnchor, bottom: plate.bottomAnchor, right: plate.rightAnchor, paddingLeft: 40, paddingBottom: 10)
        
        flagImage.anchor(top: plate.topAnchor, left: plate.leftAnchor, paddingTop: 20, paddingLeft: 20, width: 30, height: 20)
        
        
        azLabel.anchor(top: flagImage.bottomAnchor, paddingTop: 3)
        azLabel.centerX(inView: flagImage)
        azLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
}
