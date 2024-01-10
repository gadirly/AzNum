//
//  HeaderCollectionReusableView.swift
//  AzNum
//
//  Created by Babek Gadirli on 27.10.23.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ən son elanlar"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        
        return label
    }()
    
    var seeAllBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hamısına bax", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
//        addSubview(seeAllBtn)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
//        seeAllBtn.anchor(top: topAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitles(title: String) {
        titleLabel.text = title
    }
    
}
