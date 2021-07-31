//
//  WriteReviewViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 01.08.2021..
//

import Foundation
import UIKit

class WriteReviewViewController: UIViewController{
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        submitButton.layer.cornerRadius = 20
    }
    
}

// MARK: - Private methods

private extension WriteReviewViewController{
    
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
        
        navigationItem.title = "Write a Review"
    }
    
}
