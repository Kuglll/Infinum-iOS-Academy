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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func incrementButton() {
        x += 1
        self.counterLabel.text = String(x)
    }
    
    @IBAction func startButton() {
        activityIndicator.startAnimating()
    }
    
    @IBAction func stopButton() {
        activityIndicator.stopAnimating()
    }
}

