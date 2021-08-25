//
//  AppDelegate.swift
//  TV Shows
//
//  Created by Mark Frelih on 08.07.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationController = UINavigationController()
        
        let decoder = PropertyListDecoder()
        if
            let data = UserDefaults.standard.data(forKey: Constants.authInfo),
            let decodedAuthInfo = try? decoder.decode(AuthInfo.self, from: data)
        {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "HomeStoryboard", bundle:nil)
            let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            homeViewController.setAuthInfo(authInfo: decodedAuthInfo)
            
            navigationController.viewControllers = [homeViewController]
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Login", bundle:nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.viewControllers = [loginViewController]
        }
        
        window?.rootViewController = navigationController
        
        return true
    }

}

