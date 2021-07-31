//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Mark Frelih on 31.07.2021..
//

import Foundation
import UIKit

class ShowDetailsViewController : UIViewController{
    
    var show: ShowLocal? = nil
    var authInfo: AuthInfo? = nil
    
    @IBOutlet weak var showDetailsTableView: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return makeShowDetailsHeaderCell(from: tableView)
        }
        return makeReviewCell(from: tableView)
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
    
    func makeReviewCell(from tableView: UITableView) -> ReviewCell{
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: ReviewCell.self)
        ) as! ReviewCell
        cell.configure()
        return cell
    }
    
    func setupTableView() {
        showDetailsTableView.estimatedRowHeight = 110
        showDetailsTableView.rowHeight = UITableView.automaticDimension

        // Little trick to remove empty table view cells from the screen, play with removing it.
        showDetailsTableView.tableFooterView = UIView()
    }
    
}
