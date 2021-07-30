//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 18.07.2021..
//

import Foundation
import UIKit

class HomeViewController : UIViewController{
 
    var userResponse: UserResponse? = nil
    var authInfo: AuthInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setUserResponse(userResponse: UserResponse){
        self.userResponse = userResponse
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}
