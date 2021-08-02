//
//  ProfileDetailsViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 02.08.2021..
//

import Foundation
import UIKit

class ProfileDetailsViewController: UIViewController{
    
    var authInfo: AuthInfo? = nil
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        styleLogoutButton()
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}

// MARK: - IBAction

private extension ProfileDetailsViewController{
    
    @IBAction func changeProfileButtonHandler(_ sender: Any) {
        //Implement image uploading
    }
    
    @IBAction func logoutButtonHandler(_ sender: Any) {
        //Implement logout
    }
    
}

// MARK: - Private methods

private extension ProfileDetailsViewController {
    
    @objc func didSelectClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
        )
        
        navigationItem.title = "My Account"
    }
    
    func styleLogoutButton(){
        logoutButton.layer.cornerRadius = 25.0
    }
    
}
