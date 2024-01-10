//
//  ProfileViewController.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = UserViewModel()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 1
        
        return label
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFit
        
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateUI()
    }
    
    private func configureUI() {
        title = "Hesabım"
        view.backgroundColor = .white
        
        view.addSubview(profileImage)
        profileImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, width: 50, height: 50)
        profileImage.centerX(inView: view)
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: profileImage.bottomAnchor, paddingTop: 10)
        nameLabel.centerX(inView: view)
        
    }
    
    private func updateUI() {
        viewModel.getCurrentUser { [weak self] in
            guard let self = self  else {
                return
            }
            
            guard let name = viewModel.user?.name, let surname = viewModel.user?.surname else {
                return
            }
            
            print(name)
            
            self.nameLabel.text = name + " " + surname
            
        }
    }
    

}
