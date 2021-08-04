//
//  WriteReviewViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 01.08.2021..
//

import Foundation
import UIKit
import SVProgressHUD

protocol ReviewWrittenDelegate: AnyObject {
    func reviewWritten()
}

class WriteReviewViewController: UIViewController {
    
    var authInfo: AuthInfo? = nil
    var showId: String? = nil
    
    weak var delegate: ReviewWrittenDelegate?
    
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var commentTextField: UITextField!
    @IBOutlet private weak var ratingView: RatingView!
    
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

private extension WriteReviewViewController {
    
    @IBAction func submitButtonActionHandler(_ sender: Any) {
        guard
            let showId = showId,
            let showIdInt = Int(showId),
            let authInfo = authInfo
        else {
            return
        }
        ApiManager.instance.postReview(
            comment: commentTextField.text ?? "",
            rating: ratingView.rating,
            showId: showIdInt,
            authInfo: authInfo
        ) { [weak self] result in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            
            switch result{
            case .success(_):
                self.delegate?.reviewWritten()
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.showUIAlert(error: error)
            }
        }
    }
    
}

// MARK: - Private methods

private extension WriteReviewViewController {
    
    @objc func didSelectClose() {
        dismiss(animated: true)
    }
    
    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
        )
        
        navigationItem.title = "Write a Review"
    }
    
    func showUIAlert(error: Error) {
        let alertController = UIAlertController(title: "An error has occured", message: "Error: \(error)", preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(oKAction)

        present(alertController, animated: true)
    }
    
}
