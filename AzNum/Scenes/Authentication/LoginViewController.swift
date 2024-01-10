//
//  LoginViewController.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import UIKit

protocol LoginviewControllerDelegate: AnyObject {
    func didAuthenticated()
}

class LoginViewController: UIViewController {
    

    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    weak var delegate: LoginviewControllerDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedTitle(firstTitle: "Az", secondTitle: "Num", ofSize: 38)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.applyCustomTF(placeholder: "Email")
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.applyCustomTF(placeholder: "Şifrə")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    private lazy var loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 184/255.0, green: 106/255.0, blue: 196/255.0, alpha: 0.2)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let forgotPasswordBtn: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstTitle: "Şifrəni Unutmusan? ", secondTitle: "Yardım alın.", ofSize: 16)
        return button
    }()
    
    private lazy var dontHaveAccntBtn: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstTitle: "Hesabın yoxdur? ", secondTitle: "Yeni hesab yarat", ofSize: 16)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        configureNotifications()

    }
    
    // MARK: - Actions
    
    @objc func handleRegister(){
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginBtnClicked() {
        guard let email = emailTextField.text, let password = passwordTextField.text
        else {return}
        
        AuthService.loginUser(withEmail: email, password: password) { [weak self]  _, error in
            if let error {
                print("DEBUG: Failed to log in user: \(error.localizedDescription)")
                return
            }
            
            self?.delegate?.didAuthenticated()
            self?.dismiss(animated: true)
        }
    }
    
    
    @objc func textDidChange(sender: UITextField) {
        switch sender {
        case emailTextField:
            viewModel.email = emailTextField.text
        case passwordTextField:
            viewModel.password = passwordTextField.text
        default:
            print("Default case")
        }
        
        loginBtn.backgroundColor = viewModel.buttonBackgroundColor
        loginBtn.isEnabled = viewModel.formIsValid
    }
    
    
    // MARK: - Helpers
    func configureUi(){
        
        navigationController?.navigationBar.isHidden = true
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemCyan.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginBtn, forgotPasswordBtn])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32,
        paddingRight: 32)
        
        view.addSubview(dontHaveAccntBtn)
        dontHaveAccntBtn.centerX(inView: view)
        dontHaveAccntBtn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotifications() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

}

