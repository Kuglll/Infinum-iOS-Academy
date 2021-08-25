//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 18.07.2021..
//

import Foundation
import UIKit
import SVProgressHUD

class HomeViewController : UIViewController{
 
    var userResponse: UserResponse? = nil
    var authInfo: AuthInfo? = nil
    var notificationToken: NSObjectProtocol?
    
    private var shows: [ShowLocal?] = [nil]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShowsList()
        setupTableView()
        showNavBar()
        setupRightNavigationAction()
        addLogoutObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(notificationToken!)
    }
    
    func setUserResponse(userResponse: UserResponse){
        self.userResponse = userResponse
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TVShowTableViewCell.self),
            for: indexPath
        ) as! TVShowTableViewCell

        cell.configure(with: shows[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = shows[indexPath.row]
        
        let storyBoard = UIStoryboard(name: "ShowDetailsStoryboard", bundle:nil)
        let showDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "ShowDetailsViewController") as! ShowDetailsViewController
        
        guard
            let authInfo = authInfo
        else {
            return
        }
        showDetailsViewController.setShow(show: item)
        showDetailsViewController.setAuthInfo(authInfo: authInfo)
        
        navigationController?.pushViewController(showDetailsViewController, animated: true)
    }
    
}


// MARK: - private methods

private extension HomeViewController{
    
    func showUIAlert(error: Error){
        let alertController = UIAlertController(title: "An error has occured", message: "Error: \(error)", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
    func getShowsList(){
        guard
            let unwrappedAuthInfo = authInfo
        else {
            return
        }
        
        SVProgressHUD.show()
        ApiManager.instance.getShowsList(authInfo: unwrappedAuthInfo) { [weak self] result in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            
            switch result{
            case .success(let showsResponse):
                self.shows = []
                showsResponse.shows.forEach{ show in
                    self.shows.append(
                        ShowLocal(
                            id: show.id,
                            averageRating: show.averageRating,
                            description: show.description,
                            imageUrl: show.imageUrl,
                            numberOfReviews: show.numOfReviews,
                            title: show.title
                        )
                    )
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showUIAlert(error: error)
            }
        }
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension

        // Little trick to remove empty table view cells from the screen, play with removing it.
        tableView.tableFooterView = UIView()
    }
    
    func showNavBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupRightNavigationAction(){
        let profileImage = UIImage(named: "ic-profile")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(navigateToProfileDetails))

    }
    
    @objc func navigateToProfileDetails(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProfileDetailsStoryboard", bundle:nil)
        let profileDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileDetailsViewController") as! ProfileDetailsViewController
        
        guard
            let unwrappedAuthInfo = authInfo
        else {
            return
        }
        profileDetailsViewController.setAuthInfo(authInfo: unwrappedAuthInfo)
        
        let navigationController = UINavigationController(rootViewController: profileDetailsViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func addLogoutObserver(){
        notificationToken = NotificationCenter
            .default
            .addObserver(forName: NotificationDidLogout, object: nil, queue: nil, using: { [weak self] _ in
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Login", bundle:nil)
                let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
                self?.navigationController?.setNavigationBarHidden(true, animated: false)
                self?.navigationController?.setViewControllers([loginViewController], animated: true)
            })
    }
    
}
