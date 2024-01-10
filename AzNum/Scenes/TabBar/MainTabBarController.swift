//
//  MainTabBarController.swift
//  AzNum
//
//  Created by Gadirli on 06.09.23.
//

import UIKit
import Firebase



class MainTabBarController: UITabBarController {
    
    let centerButton = UIButton(type: .custom)
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        configureBars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: Helpers
    
    private func configureBars(){
        
        let buttonSize: CGFloat = 60
        centerButton.frame = CGRect(x: (view.bounds.width - buttonSize) / 2, y: view.bounds.height - buttonSize - 30, width: buttonSize, height: buttonSize)
        centerButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        centerButton.tintColor = .white
        centerButton.backgroundColor = UIColor.systemBlue
        centerButton.layer.cornerRadius = buttonSize / 2
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        
        // Add the center button to the tab bar
        view.addSubview(centerButton)
        
        let homeVc = HomeViewController()
        let vc1 = UINavigationController(rootViewController: homeVc)
        
        let vc2 = UINavigationController(rootViewController: SavedViewController())
        
        let middleTab = UIViewController()
        
        let vc3 = UINavigationController(rootViewController: UIViewController())
        
        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.circle")
        vc2.tabBarItem.image = UIImage(systemName: "heart.circle")
        vc3.tabBarItem.image = UIImage(systemName: "message.circle")
        vc4.tabBarItem.image = UIImage(systemName: "person.circle")
        
        vc2.title = "Seçilmişlər"
        vc3.title = "İsmarıclar"
        vc4.title = "Hesabım"
        

        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        setViewControllers([vc1, vc2, middleTab, vc3, vc4], animated: true)
    }
    
    @objc func centerButtonTapped() {
        
        let vc = NewItemViewController()
        
        let newItemNav = UINavigationController(rootViewController: vc)
        newItemNav.modalPresentationStyle = .fullScreen
        
        present(newItemNav, animated: true)
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
}




