//
//  ProfileDetailsViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 02.08.2021..
//

import Foundation
import UIKit
import SVProgressHUD
import Kingfisher

class ProfileDetailsViewController: UIViewController{
    
    var authInfo: AuthInfo? = nil
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        styleLogoutButton()
        getCurrentLoggedInUser()
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
    
    func getCurrentLoggedInUser(){
        guard
            let unwrappedAuthInfo = authInfo
        else {
            return
        }
        
        SVProgressHUD.show()
        ApiManager.instance.getCurrentLoggedInUser(authInfo: unwrappedAuthInfo){[weak self] result in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            
            switch result{
            case .success(let userResponse):
                self.setProfileDetails(user: userResponse.user)
            case .failure(let error):
                self.showUIAlert(error: error)
            }
        }
    }

    func setProfileDetails(user: User){
        usernameLabel.text = user.email
        userImageView.kf.setImage(with: user.imageUrl, placeholder: UIImage(named: "ic-profile-placeholder"))
    }
    
    func showUIAlert(error: Error){
        let alertController = UIAlertController(title: "An error has occured", message: "Error: \(error)", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
}
