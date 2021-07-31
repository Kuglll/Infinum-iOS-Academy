//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 31.07.2021..
//

import Foundation
import UIKit

class ShowDetailsViewController : UIViewController{
    
    var showId: String? = nil
    var authInfo: AuthInfo? = nil
    @IBOutlet weak var showIdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIdLabel.text = showId
    }
    
    func setShowId(showId: String){
        self.showId = showId
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}
