//
//  MultilineTextField.swift
//  AzNum
//
//  Created by Babek Gadirli on 28.11.23.
//

import Foundation

import UIKit

class MultilineTextField: UITextField {
    let padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) // Adjust the padding as needed
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.4
        layer.cornerRadius = 5
        textAlignment = .left
        contentVerticalAlignment = .top
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
}
