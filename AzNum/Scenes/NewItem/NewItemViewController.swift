//
//  NewItemViewController.swift
//  AzNum
//
//  Created by Babek Gadirli on 27.10.23.
//

import UIKit
import Firebase

enum PickerTags {
    case series
    case firstLetter
}

class NewItemViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = PlateViewModel()
    var userViewModel = UserViewModel()
    
    let firstPartData = SERIES
    let secondPartData = LETTERS
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let plateFormCard: CustomCardView = {
        let view = CustomCardView()
        view.setTitleText(text: "Qeydiyyat nişanı")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let phoneFormCard: CustomCardView = {
        let view = CustomCardView()
        view.setTitleText(text: "Əlaqə nömrəsi")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let priceFormCard: CustomCardView = {
        let view = CustomCardView()
        view.setTitleText(text: "Qiymət")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let descriptionFormCard: CustomCardView = {
        let view = CustomCardView()
        view.setTitleText(text: "Əlavə Məlumat")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let phoneNumberOperatorTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.placeholder = "000"
        
        return textField
    }()
    
    private let phoneNumberField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.placeholder = "Nömrəni daxil edin"
        textField.keyboardType = .numberPad
        
        
        return textField
    }()
    
    
    private let seriesField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.placeholder = "00"
        
        return textField
    }()
    
    private let firstLetterField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.placeholder = "A"
        
        return textField
    }()
    
    private let secondLetterField: UITextField = {
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
    
    private let phoneNumberOperatorPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 2
        return pickerView
    }()
    
    private let plateTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 0.4
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.placeholder = "000"
        return textField
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 0.4
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.placeholder = "Qiymət daxil edin"
        
        return textField
    }()
    
    private let aznThumbnail: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "manat")
        return image
    }()
    
    private var descriptionTextField: MultilineTextField = {
        let textField = MultilineTextField()
        textField.placeholder = "Əlavə məlumat daxil edin"
        
        return textField
    }()
    
    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yeni Elan Yarat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(submitBtnClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var bottomButtonConstraint = CGFloat()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configurePickerToolbar()
        notificationObservers()
        self.hideKeyboardWhenTappedAround()
        
        userViewModel.getCurrentUser {
            
        }
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        title = "Yeni Elan"
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        
        let closeBtn = UIBarButtonItem(title: "Bağla", style: .done, target: self, action: #selector(handleDismissBtn))
        closeBtn.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = closeBtn
        
        
        seriesField.delegate = self
        firstLetterField.delegate = self
        secondLetterField.delegate = self
        phoneNumberOperatorTextField.delegate = self
        descriptionTextField.delegate = self
        plateTextField.delegate = self
        phoneNumberField.delegate = self
        priceTextField.delegate = self
        
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(plateFormCard)
        NSLayoutConstraint.activate([
            plateFormCard.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            plateFormCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            plateFormCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            plateFormCard.heightAnchor.constraint(equalToConstant: 95)
        ])
        
        seriesPickerView.delegate = self
        seriesPickerView.dataSource = self
        seriesField.inputView = seriesPickerView
        
        firstLetterPickerView.delegate = self
        firstLetterPickerView.dataSource = self
        firstLetterField.inputView = firstLetterPickerView
        
        secondLetterPickerView.delegate = self
        secondLetterPickerView.dataSource = self
        secondLetterField.inputView = secondLetterPickerView
        
        phoneNumberOperatorPickerView.delegate = self
        phoneNumberOperatorPickerView.dataSource = self
        phoneNumberOperatorTextField.inputView = phoneNumberOperatorPickerView
        
        let plateInputStackView = UIStackView(arrangedSubviews: [seriesField, firstLetterField, secondLetterField, plateTextField])
        plateInputStackView.axis = .horizontal
        plateInputStackView.spacing = 10
        plateInputStackView.distribution = .fillEqually
        
        plateFormCard.addSubview(plateInputStackView)
        plateInputStackView.anchor(top: plateFormCard.topAnchor, left: plateFormCard.leftAnchor, right: plateFormCard.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingRight: 10, height: 40)
        
        scrollView.addSubview(phoneFormCard)
        NSLayoutConstraint.activate([
            phoneFormCard.topAnchor.constraint(equalTo: plateFormCard.bottomAnchor, constant: 30),
            phoneFormCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            phoneFormCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            phoneFormCard.heightAnchor.constraint(equalToConstant: 95)
        ])
        
        phoneFormCard.addSubview(phoneNumberField)
        phoneFormCard.addSubview(phoneNumberOperatorTextField)
        
        phoneNumberOperatorTextField.anchor(top: phoneFormCard.topAnchor, left: phoneFormCard.leftAnchor, paddingTop: 40, paddingLeft: 10, width: 70, height: 40)
        
        phoneNumberField.anchor(top: phoneFormCard.topAnchor, left: phoneNumberOperatorTextField.rightAnchor, right: phoneFormCard.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 10, height: 40)
        
        
        scrollView.addSubview(priceFormCard)
        NSLayoutConstraint.activate([
            priceFormCard.topAnchor.constraint(equalTo: phoneFormCard.bottomAnchor, constant: 30),
            priceFormCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            priceFormCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            priceFormCard.heightAnchor.constraint(equalToConstant: 95)
        ])
        
        priceFormCard.addSubview(priceTextField)
        priceTextField.anchor(top: priceFormCard.topAnchor, left: priceFormCard.leftAnchor, right: priceFormCard.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingRight: 45, height: 40)
        priceFormCard.addSubview(aznThumbnail)
        aznThumbnail.centerY(inView: priceTextField)
        aznThumbnail.anchor(left: priceTextField.rightAnchor, paddingLeft: 10, width: 20, height: 20)
        
        
        
        scrollView.addSubview(descriptionFormCard)
        NSLayoutConstraint.activate([
            descriptionFormCard.topAnchor.constraint(equalTo: priceFormCard.bottomAnchor, constant: 30),
            descriptionFormCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionFormCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionFormCard.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        descriptionFormCard.addSubview(descriptionTextField)
        descriptionTextField.anchor(top: descriptionFormCard.topAnchor, left: descriptionFormCard.leftAnchor, bottom: descriptionFormCard.bottomAnchor, right: descriptionFormCard.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        scrollView.addSubview(submitBtn)
        NSLayoutConstraint.activate([
            submitBtn.topAnchor.constraint(equalTo: descriptionFormCard.bottomAnchor, constant: 30),
            submitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            submitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            submitBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            submitBtn.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    func configurePickerToolbar() {
        let pickerToolbar = UIToolbar()
        pickerToolbar.sizeToFit()
        seriesField.inputAccessoryView = pickerToolbar
        firstLetterField.inputAccessoryView = pickerToolbar
        secondLetterField.inputAccessoryView = pickerToolbar
        phoneNumberOperatorTextField.inputAccessoryView = pickerToolbar
        
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(handleDone))
        pickerToolbar.setItems([doneButton], animated: true)
        pickerToolbar.isUserInteractionEnabled = true
    }
    
    func notificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: Actions
    
    
    @objc private func handleDismissBtn() {
        self.dismiss(animated: true)
    }
    
    @objc private func handleDone() {
        view.endEditing(true)
    }
    
    @objc private func submitBtnClicked() {
        guard let seriesNumber = seriesField.text,
              let firstLetter = firstLetterField.text,
              let secondLetter = secondLetterField.text,
              let plateEnding = plateTextField.text,
              let number = phoneNumberField.text,
              let price = priceTextField.text,
              let user = userViewModel.user,
              let description = descriptionTextField.text else {
            return
        }
        
        
        
        let plate = CarPlate(id: "", plateSeries: seriesNumber, plateFirstChar: firstLetter, plateSecondChar: secondLetter, plateEnding: plateEnding, owner: user.name + " " + user.surname, ownerID: viewModel.uid, phoneNumber: number, price: price, description: description, date: ServerValue.timestamp())
        
        
        viewModel.addCarPlate(plateItem: plate) {
            self.dismiss(animated: true)
        }
        
        
    }
    
    
}

extension NewItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case firstLetterPickerView:
            return secondPartData.count
        case secondLetterPickerView:
            return secondPartData.count
        case seriesPickerView:
            return firstPartData.count
        case phoneNumberOperatorPickerView:
            return PHONE_OPERATORS.count
        default:
            return 0
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case firstLetterPickerView:
            return secondPartData[row]
        case secondLetterPickerView:
            return secondPartData[row]
        case seriesPickerView:
            return firstPartData[row]
        case phoneNumberOperatorPickerView:
            return PHONE_OPERATORS[row]
        default:
            return "Null"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case seriesPickerView:
            seriesField.text = firstPartData[row]
        case firstLetterPickerView:
            firstLetterField.text = secondPartData[row]
        case secondLetterPickerView:
            secondLetterField.text = secondPartData[row]
        case phoneNumberOperatorPickerView:
            phoneNumberOperatorTextField.text = PHONE_OPERATORS[row]
        default:
            printContent("Default")
        }
    }
}

extension NewItemViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        var isDecimal = allowedCharacters.isSuperset(of: characterSet)
        var maxLength = 0
        var isPasted = true
        
        
        switch textField {
        case seriesField:
            maxLength = 2
        case firstLetterField:
            maxLength = 2
        case secondLetterField:
            maxLength = 2
        case phoneNumberOperatorTextField:
            maxLength = 3
        case plateTextField:
            maxLength = 3
        case descriptionTextField:
            maxLength = 530
            isDecimal = true
            isPasted = true
        case firstLetterField:
            maxLength = 1
        case secondLetterField:
            maxLength = 1
        case phoneNumberField:
            maxLength = 7
        case priceTextField:
            maxLength = 6
        default:
            maxLength = 0
        }
        
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        return newString.count <= maxLength && isDecimal && isPasted
    }
}

// MARK: Keyboard Notifications

extension NewItemViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        print("Keyboard showed")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + keyboardHeight)
        }
        else{
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 250)
        }
    }
    
    // Reset contentInset when the keyboard hides
    @objc func keyboardWillHide(_ notification: Notification) {
        print("Keyboard hidden")
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - keyboardHeight)
        }
        else{
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 250)
        }
    }
}
