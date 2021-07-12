//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 09.07.2021..
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    

    @IBOutlet weak var counterLabel: UILabel!
    var x: Int = 0
    
    @IBAction func incrementButton(_ sender: Any) {
        x += 1
        self.counterLabel.text = String(x)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

