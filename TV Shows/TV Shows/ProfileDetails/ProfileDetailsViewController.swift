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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
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
    
}
