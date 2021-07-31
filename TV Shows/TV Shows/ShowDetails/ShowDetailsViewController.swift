//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 31.07.2021..
//

import Foundation
import UIKit
import SVProgressHUD

class ShowDetailsViewController : UIViewController{
    
    var show: ShowLocal? = nil
    var authInfo: AuthInfo? = nil
    
    private var reviews: [Review?] = [nil]
    
    @IBOutlet weak var showDetailsTableView: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getReviews()
        setupNavBar()
        setupTableView()
    }
    
    func setShow(show: ShowLocal?){
        self.show = show
    }
    
    func setAuthInfo(authInfo: AuthInfo){
        self.authInfo = authInfo
    }
    
}

// MARK: - UITableViewDataSource

extension ShowDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return makeShowDetailsHeaderCell(from: tableView)
        }
        return makeReviewCell(from: tableView, index: indexPath.row)
    }
}

// MARK: - Private methods

private extension ShowDetailsViewController{
    
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.view.backgroundColor = UIColor.white
        self.title = show?.title
    }
    
    func makeShowDetailsHeaderCell(from tableView: UITableView) -> ShowDetailsHeaderCell{
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: ShowDetailsHeaderCell.self)
        ) as! ShowDetailsHeaderCell
        cell.configure(show: show)
        return cell
    }
    
    func makeReviewCell(from tableView: UITableView, index: Int) -> ReviewCell{
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: ReviewCell.self)
        ) as! ReviewCell
        if index < reviews.count {
            cell.configure(review: reviews[index])
        } else {
            cell.configure(review: nil)
        }
        return cell
    }
    
    func setupTableView() {
        showDetailsTableView.estimatedRowHeight = 110
        showDetailsTableView.rowHeight = UITableView.automaticDimension

        // Little trick to remove empty table view cells from the screen, play with removing it.
        showDetailsTableView.tableFooterView = UIView()
    }
    
    func getReviews(){
        guard
            let unwrappedAuthInfo = authInfo,
            let unwrappedShowId = show?.id
        else {
            return
        }
        
        SVProgressHUD.show()
        ApiManager.instance.getReviewsForShow(showId: unwrappedShowId, authInfo: unwrappedAuthInfo) { [weak self] result in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            
            switch result{
            case .success(let reviewsResponse):
                reviewsResponse.reviews.forEach({review in
                  
                    self.reviews.append(review)
                    self.showDetailsTableView.reloadData()
                })
            case .failure(let error):
                self.showUIAlert(error: error)
            }
        }
    }
    
    func showUIAlert(error: Error){
        let alertController = UIAlertController(title: "An error has occured", message: "Error: \(error)", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
}
