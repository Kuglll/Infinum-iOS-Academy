//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 31.07.2021..
//

import Foundation
import UIKit

class ShowDetailsViewController : UIViewController{
    
    var show: ShowLocal? = nil
    var authInfo: AuthInfo? = nil
    @IBOutlet weak var showIdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIdLabel.text = show?.id
        
        
    }
    
    func setShow(show: ShowLocal?){
        self.show = show
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}
