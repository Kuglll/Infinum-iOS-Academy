//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 09.07.2021..
//

import Foundation
import UIKit
import SVProgressHUD

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
            SVProgressHUD.show()
            ApiManager.instance.alamofireCodableRegisterUserWith(
                email: usernameText,
                password: passwordText,
                success: { (user, headers) in
                    SVProgressHUD.dismiss()
                    self.storeUser(user: user)
                    print("Headers: \(headers)")
                    self.navigateToHome()
                },
                failure: { (error) in
                    SVProgressHUD.dismiss()
                    self.showError(error: error)
                }
            )
        }
    }
    
    @IBAction func login() {
        if let usernameText = usernameTextField.text,
           let passwordText = passwordTextField.text {
            SVProgressHUD.show()
            ApiManager.instance.loginUserWith(
                email: usernameText,
                password: passwordText,
                success: { (user, headers) in
                    SVProgressHUD.dismiss()
                    self.storeUser(user: user)
                    print("Headers: \(headers)")
                    self.navigateToHome()
                },
                failure: { (error) in
                    SVProgressHUD.dismiss()
                    self.showError(error: error)
                }
            )
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
    
    private func storeUser(user: UserResponse){
        userResponse = user
    }
    
    private func showError(error: String){
        print("API/Serialization failure: \(error)")
    }
    
    private func navigateToHome(){
        //TODO: Navigate to home
    }
    
}
