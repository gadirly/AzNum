//
//  SearchViewController.swift
//  AzNum
//
//  Created by Babek Gadirli on 11.12.23.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = PlateViewModel()
    
    private let plateInputView: PlateInputView = {
        let view = PlateInputView()
        
        return view
    }()
    
    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Axtar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(submitBtnClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        
        view.backgroundColor = .white
        title = "Axtar"
        
        let closeBtn = UIBarButtonItem(title: "Bağla", style: .done, target: self, action: #selector(handleDismissBtn))
        closeBtn.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = closeBtn
        
        view.addSubview(plateInputView)
        plateInputView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 10, paddingRight: 10, height: 95)
        
        view.addSubview(submitBtn)
        submitBtn.anchor(top: plateInputView.bottomAnchor, left: plateInputView.leftAnchor, right: plateInputView.rightAnchor, paddingTop: 20)
    }
    
    // MARK: Actions
    
    @objc func submitBtnClicked() {
        
        guard let plateSeries = plateInputView.seriesField.text,
              let plateFirstChar = plateInputView.firstLetterField.text,
              let plateSecondChar = plateInputView.secondLetterField.text,
              let plateEnding = plateInputView.plateTextField.text else {
            return
        }
        
        viewModel.searchItems(plateSeries: plateSeries, plateFirstChar: plateFirstChar, plateSecondChar: plateSecondChar, plateEnding: plateEnding) { [weak self] in
            let vc = SearchResultsViewController()
            
            guard let viewModel = self?.viewModel else {
                return
            }
            vc.configureView(viewModel: viewModel)
            print(viewModel.items)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        

    }
    
    @objc func handleDismissBtn() {
        self.dismiss(animated: true)
    }
}


