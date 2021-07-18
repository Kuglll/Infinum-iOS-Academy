//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 09.07.2021..
//

import Foundation
import UIKit
import SVProgressHUD
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var togglePasswordIcon: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private var rememberMeChecked = false
    private var passwordVisible = false
    private var userResponse: UserResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        styleTextFields(textFields: [usernameTextField, passwordTextField])
        styleLoginButton()
        toggleLoginAndRegisterButtons(enabled: false)
    }
    
    @IBAction func rememberMeButtonAction() {
        rememberMeChecked = !rememberMeChecked
        if(rememberMeChecked){
            rememberMeButton.setImage(UIImage(named: "CheckboxSelected"), for: .normal)
        } else {
            rememberMeButton.setImage(UIImage(named: "CheckboxUnselected"), for: .normal)
        }
    }
    
    @IBAction func togglePasswordVisibility() {
        passwordVisible = !passwordVisible
        if(passwordVisible){
            togglePasswordIcon.setImage(UIImage(named: "PasswordVisible"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }else {
            togglePasswordIcon.setImage(UIImage(named: "PasswordInvisible"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func register() {
        if let usernameText = usernameTextField.text,
           let passwordText = passwordTextField.text {
            alamofireCodableRegisterUserWith(email: usernameText, password: passwordText)
        }
    }
    
    @IBAction func login() {
        if let usernameText = usernameTextField.text,
           let passwordText = passwordTextField.text {
            loginUserWith(email: usernameText, password: passwordText)
        }
    }
    
    private func styleTextFields(textFields: [UITextField]){
        for textField in textFields{
            
            //Bottom border
            let usernameBottomLine = CALayer()
            usernameBottomLine.frame = CGRect(x: -15, y: textField.frame.height - 2, width: textField.frame.width - 10 , height: 1)
            usernameBottomLine.backgroundColor = UIColor.white.cgColor
            textField.borderStyle = .none
            textField.layer.addSublayer(usernameBottomLine)
            
            //Placeholder
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.7)])
            
            textField.addTarget(self, action: #selector(checkIfButtonsNeedToBeEnabled), for: .editingChanged)
        }
    }
    
    @objc private func checkIfButtonsNeedToBeEnabled(){
        if let unwrappedCountUsername = usernameTextField.text?.count,
           unwrappedCountUsername > 0,
           let unwrappedCountPassword = passwordTextField.text?.count,
           unwrappedCountPassword > 0 {
            toggleLoginAndRegisterButtons(enabled: true)
        } else {
            toggleLoginAndRegisterButtons(enabled: false)
        }
    }
    
    private func toggleLoginAndRegisterButtons(enabled: Bool){
        loginButton.isEnabled = enabled
        loginButton.backgroundColor = UIColor(white: 1, alpha: enabled ? 1 : 0.3)
        if(enabled){
            loginButton.setTitleColor(UIColor(named: "PrimaryColor")?.withAlphaComponent(1), for: .normal)
        } else {
            loginButton.setTitleColor(UIColor(white: 1, alpha: 0.4), for: .normal)
        }
                
        registerButton.isEnabled = enabled
        registerButton.setTitleColor(UIColor(white: 1, alpha: enabled ? 1 : 0.4), for: .normal)
    }
    
    private func styleLoginButton(){
        loginButton.layer.cornerRadius = 21.5
        loginButton.clipsToBounds = true
    }

    
    func alamofireCodableRegisterUserWith(email: String, password: String) {
        SVProgressHUD.show()

        let parameters: [String: String] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]

        AF
            .request(
                "https://tv-shows.infinum.academy/users",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    self.userResponse = userResponse
                    //TODO: Navigate to home
                    SVProgressHUD.showSuccess(withStatus: "Success")
                case .failure(let error):
                    print("API/Serialization failure: \(error)")
                    SVProgressHUD.showError(withStatus: "Failure")
                }
            }
    }
    
    func loginUserWith(email: String, password: String) {
        SVProgressHUD.show()

        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]

        AF
            .request(
                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    SVProgressHUD.dismiss()
                    self.userResponse = userResponse
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    //self?.handleSuccesfulLogin(for: userResponse.user, headers: headers)
                    //TODO: Navigate to home
                case .failure(let error):
                    print("API/Serialization failure: \(error)")
                    SVProgressHUD.showError(withStatus: "Failure")
                }
            }
    }
    
}
