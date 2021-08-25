//
//  ProfileDetailsViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 02.08.2021..
//

import Foundation
import UIKit
import SVProgressHUD
import Kingfisher

let NotificationDidLogout = Notification.Name(rawValue: "NotificationDidLogout")

class ProfileDetailsViewController: UIViewController{
    
    var authInfo: AuthInfo? = nil
    private var user: User? = nil
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        styleLogoutButton()
        getCurrentLoggedInUser()
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}

extension ProfileDetailsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                uploadPhoto(image: pickedImage)
            }
            
            dismiss(animated: true, completion: nil)
        }
    
}

// MARK: - IBAction

private extension ProfileDetailsViewController{
    
    @IBAction func changeProfileButtonHandler(_ sender: Any) {
        openImagePicker()
    }
    
    @IBAction func logoutButtonHandler(_ sender: Any) {
        logout()
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
    
    func styleLogoutButton(){
        logoutButton.layer.cornerRadius = 25.0
    }
    
    func getCurrentLoggedInUser(){
        guard
            let unwrappedAuthInfo = authInfo
        else {
            return
        }
        
        SVProgressHUD.show()
        ApiManager.instance.getCurrentLoggedInUser(authInfo: unwrappedAuthInfo) { [weak self] result in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            
            switch result{
            case .success(let userResponse):
                self.setProfileDetails(user: userResponse.user)
                self.saveUser(user: userResponse.user)
            case .failure(let error):
                self.showUIAlert(error: error)
            }
        }
    }

    func setProfileDetails(user: User){
        usernameLabel.text = user.email
        userImageView.kf.setImage(with: user.imageUrl, placeholder: UIImage(named: "ic-profile-placeholder"))
    }
    
    func showUIAlert(error: Error){
        let alertController = UIAlertController(title: "An error has occured", message: "Error: \(error)", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
    func openImagePicker(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func uploadPhoto(image: UIImage){
        guard
            let unwrappedAuthInfo = authInfo,
            let email = user?.email
        else {
            return
        }
        
        SVProgressHUD.show()
        ApiManager.instance.uploadUserPhoto(image: image, email: email, authInfo: unwrappedAuthInfo, handler: {[weak self] result in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            
            switch result{
            case .success(let userResponse):
                self.setProfileDetails(user: userResponse.user)
            case .failure(let error):
                self.showUIAlert(error: error)
            }
        })
    }
    
    func saveUser(user: User?){
        self.user = user
    }
    
    func logout(){
        dismiss(animated: true, completion: {
            UserDefaults.standard.removeObject(forKey:Constants.authInfo)
            let notification = Notification(name: NotificationDidLogout)
            NotificationCenter.default.post(notification)
        })
    }
    
}
