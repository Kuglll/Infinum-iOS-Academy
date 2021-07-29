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
    
    private var userResponse: UserResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        [usernameTextField, passwordTextField].forEach(styleTextField)
        styleLoginButton()
        setupRememberMeButton()
        setupPasswordIcon()
        toggleLoginAndRegisterButtons(enabled: false)
    }
    
}

// MARK: - IBActions

private extension LoginViewController {
    
    @IBAction func rememberMeButtonAction() {
        rememberMeButton.isSelected = !rememberMeButton.isSelected
    }
    
    @IBAction func togglePasswordVisibility() {
        togglePasswordIcon.isSelected = !togglePasswordIcon.isSelected
        passwordTextField.isSecureTextEntry = !togglePasswordIcon.isSelected
    }
    
    @IBAction func registerButtonActionHandler() {
        guard
           let usernameText = usernameTextField.text,
           let passwordText = passwordTextField.text
        else {
            return
        }

        SVProgressHUD.show()
        ApiManager.instance.alamofireCodableRegisterUserWith(
            email: usernameText,
            password: passwordText,
            handler: { result in
                SVProgressHUD.dismiss()
    
                switch result{
                case .success(let tuple):
                    self.storeUser(user: tuple.0)
                    print("Headers: \(tuple.1)")
                    self.navigateToHome()
                case .failure(let error):
                    self.showError(error: error.localizedDescription)
                }
            }
        )
    }
    
    @IBAction func loginButtonActionHandler() {
        guard
            let usernameText = usernameTextField.text,
            let passwordText = passwordTextField.text
        else {
            return
        }
        
        SVProgressHUD.show()
        ApiManager.instance.loginUserWith(
            email: usernameText,
            password: passwordText,
            
            handler: { result in
                SVProgressHUD.dismiss()
                
                switch result{
                case .success(let tuple):
                    self.storeUser(user: tuple.0)
                    print("Headers: \(tuple.1)")
                    self.navigateToHome()
                case .failure(let error):
                    self.showError(error: error.localizedDescription)
                }
            }
        )
    }
}

// MARK: - private methods

private extension LoginViewController {
    
    func styleTextField(textField: UITextField){
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
    
    @objc func checkIfButtonsNeedToBeEnabled(){
        guard
            let username = usernameTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty,
            !password.isEmpty
        else {
            toggleLoginAndRegisterButtons(enabled: false)
            return
        }
        toggleLoginAndRegisterButtons(enabled: true)
    }
    
    func toggleLoginAndRegisterButtons(enabled: Bool){
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
    
    func styleLoginButton(){
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
        let storyBoard : UIStoryboard = UIStoryboard(name: "HomeStoryboard", bundle:nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
        navigationController?.setViewControllers([homeViewController], animated: true)
    }

    func setupRememberMeButton(){
        rememberMeButton.setImage(UIImage(named: "CheckboxSelected"), for: .selected)
        rememberMeButton.setImage(UIImage(named: "CheckboxUnselected"), for: .normal)
    }
    
    func setupPasswordIcon(){
        togglePasswordIcon.setImage(UIImage(named: "PasswordVisible"), for: .selected)
        togglePasswordIcon.setImage(UIImage(named: "PasswordInvisible"), for: .normal)

    }
    
}
