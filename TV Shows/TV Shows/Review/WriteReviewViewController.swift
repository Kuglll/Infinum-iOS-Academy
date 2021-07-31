//
//  WriteReviewViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 01.08.2021..
//

import Foundation
import UIKit
import SVProgressHUD

class WriteReviewViewController: UIViewController{
    
    var authInfo: AuthInfo? = nil
    var showId: String? = nil
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var ratingView: RatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        submitButton.layer.cornerRadius = 20
    }
    
    func setShowId(showId: String){
        self.showId = showId
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}

// MARK: - IBActions

private extension WriteReviewViewController{
    
    @IBAction func submitButtonActionHandler(_ sender: Any) {
        guard
            let unwrappedShowId = showId,
            let unwrappedShowIdInt = Int(unwrappedShowId),
            let unwrappedAuthInfo = authInfo
        else {
            return
        }
        ApiManager.instance.postReview(
            comment: commentTextField.text ?? "",
            rating: ratingView.rating,
            showId: unwrappedShowIdInt,
            authInfo: unwrappedAuthInfo
        ){ [weak self] result in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            
            switch result{
            case .success(_):
                //navigate back and refresh reviews
                print("navigate back and refresh reviews")
            case .failure(let error):
                self.showUIAlert(error: error)
            }
        }
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
    
    func showUIAlert(error: Error){
        let alertController = UIAlertController(title: "An error has occured", message: "Error: \(error)", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
}
