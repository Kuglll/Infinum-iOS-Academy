//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 18.07.2021..
//

import Foundation
import UIKit
import SVProgressHUD

class HomeViewController : UIViewController{
 
    var userResponse: UserResponse? = nil
    var authInfo: AuthInfo? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let unwrappedAuthInfo = authInfo
        else {
            return
        }
        
        SVProgressHUD.show()
        ApiManager.instance.getShowsList(authInfo: unwrappedAuthInfo) { [weak self] result in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            
            switch result{
            case .success(let showsResponse):
                print(showsResponse)
            case .failure(let error):
                self.showUIAlert(error: error)
            }
        }
    }
    
    func setUserResponse(userResponse: UserResponse){
        self.userResponse = userResponse
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}

// MARK: - private methods

private extension HomeViewController{
    
    func showUIAlert(error: Error){
        let alertController = UIAlertController(title: "An error has occured", message: "Error: \(error)", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
}
