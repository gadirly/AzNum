//
//  PlateInputView.swift
//  AzNum
//
//  Created by Babek Gadirli on 12.12.23.
//

import UIKit


class PlateInputView: UIView {
    
    // MARK: Properties
    
    private let plateFormCard: CustomCardView = {
        let view = CustomCardView()
        view.setTitleText(text: "Qeydiyyat nişanı")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let seriesField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.placeholder = "00"
        
        return textField
    }()
    
    let firstLetterField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.placeholder = "A"
        
        return textField
    }()
    
    let secondLetterField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.placeholder = "A"
        
        return textField
    }()
    
    private let seriesPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 0
        
        return pickerView
    }()
    
    private let firstLetterPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 1
        return pickerView
    }()
    
    private let secondLetterPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 2
        return pickerView
    }()
    
    let plateTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 0.4
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.placeholder = "000"
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configurePickerToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        
        seriesField.delegate = self
        firstLetterField.delegate = self
        secondLetterField.delegate = self
        plateTextField.delegate = self
        
        addSubview(plateFormCard)
        plateFormCard.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        seriesPickerView.delegate = self
        seriesPickerView.dataSource = self
        seriesField.inputView = seriesPickerView
        
        firstLetterPickerView.delegate = self
        firstLetterPickerView.dataSource = self
        firstLetterField.inputView = firstLetterPickerView
        
        secondLetterPickerView.delegate = self
        secondLetterPickerView.dataSource = self
        secondLetterField.inputView = secondLetterPickerView
        
        let plateInputStackView = UIStackView(arrangedSubviews: [seriesField, firstLetterField, secondLetterField, plateTextField])
        plateInputStackView.axis = .horizontal
        plateInputStackView.spacing = 10
        plateInputStackView.distribution = .fillEqually
        
        plateFormCard.addSubview(plateInputStackView)
        plateInputStackView.anchor(top: plateFormCard.topAnchor, left: plateFormCard.leftAnchor, right: plateFormCard.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingRight: 10, height: 40)
    }
    
    func configurePickerToolbar() {
        let pickerToolbar = UIToolbar()
        pickerToolbar.sizeToFit()
        seriesField.inputAccessoryView = pickerToolbar
        firstLetterField.inputAccessoryView = pickerToolbar
        secondLetterField.inputAccessoryView = pickerToolbar
        
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(handleDone))
        pickerToolbar.setItems([doneButton], animated: true)
        pickerToolbar.isUserInteractionEnabled = true
    }
    
    @objc private func handleDone() {
        endEditing(true)
    }

}

extension PlateInputView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case firstLetterPickerView:
            return LETTERS.count
        case secondLetterPickerView:
            return LETTERS.count
        case seriesPickerView:
            return SERIES.count
        default:
            return 0
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case firstLetterPickerView:
            return LETTERS[row]
        case secondLetterPickerView:
            return LETTERS[row]
        case seriesPickerView:
            return SERIES[row]
        default:
            return "Null"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case seriesPickerView:
            seriesField.text = SERIES[row]
        case firstLetterPickerView:
            firstLetterField.text = LETTERS[row]
        case secondLetterPickerView:
            secondLetterField.text = LETTERS[row]
        default:
            printContent("Default")
        }
    }
}

extension PlateInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let isDecimal = allowedCharacters.isSuperset(of: characterSet)
        
        var maxLength = 0
        let isPasted = true
        
        
        switch textField {
        case seriesField:
            maxLength = 2
        case firstLetterField:
            maxLength = 1
        case secondLetterField:
            maxLength = 1
        case plateTextField:
            maxLength = 3
        default:
            maxLength = 0
        }
        
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        return newString.count <= maxLength && isDecimal && isPasted
    }
}
