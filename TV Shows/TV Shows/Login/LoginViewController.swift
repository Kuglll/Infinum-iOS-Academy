//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 09.07.2021..
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var rememberMeChecked = false
    var passwordVisible = false

    @IBAction func rememberMeButtonAction(_ sender: Any) {
        rememberMeChecked = !rememberMeChecked
        if(rememberMeChecked){
            rememberMeButton.setImage(UIImage(named: "CheckboxSelected"), for: .normal)
        } else {
            rememberMeButton.setImage(UIImage(named: "CheckboxUnselected"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        styleTextFields(textFields: [usernameTextField, passwordTextField])
        styleLoginButton()
        toggleLoginAndRegisterButtons(enabled: false)
        
        setupPasswordEyeIcon()
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
    
    private func setupPasswordEyeIcon(){
        let imageIcon = UIImageView()
        let invisibleIcon = UIImage(named: "PasswordInvisible")
        imageIcon.image = invisibleIcon
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: invisibleIcon?.size.width ?? 0, height: invisibleIcon?.size.height ?? 0)
        imageIcon.frame = CGRect(x: -10, y: 0, width: invisibleIcon?.size.width ?? 0, height: invisibleIcon?.size.height ?? 0)
        
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eyeIconTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func eyeIconTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let eyeIcon = tapGestureRecognizer.view as! UIImageView
        passwordVisible = !passwordVisible
        
        if(passwordVisible){
            eyeIcon.image = UIImage(named: "PasswordVisible")
            passwordTextField.isSecureTextEntry = false
        } else {
            eyeIcon.image = UIImage(named: "PasswordInvisible")
            passwordTextField.isSecureTextEntry = true
        }
        
    }

}
