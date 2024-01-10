//
//  PaddedLabel.swift
//  AzNum
//
//  Created by Babek Gadirli on 28.11.23.
//

import UIKit

class PaddedLabel: UILabel {
    let padding = UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        layer.cornerRadius = 5
        layer.masksToBounds = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let paddedRect = rect.inset(by: padding)
        super.drawText(in: paddedRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let height = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
}

