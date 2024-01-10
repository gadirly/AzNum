//
//  CustomCardView.swift
//  AzNum
//
//  Created by Babek Gadirli on 27.10.23.
//

import UIKit

class CustomCardView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        backgroundColor = .white
        dropShadow()
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleText(text: String) {
        titleLabel.text = text
    }
    
}
