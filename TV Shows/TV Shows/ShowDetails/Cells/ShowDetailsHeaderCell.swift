//
//  ShowDetailsHeaderCell.swift
//  TV Shows
//
//  Created by Mark Frelih on 31.07.2021..
//

import Foundation
import UIKit

final class ShowDetailsHeaderCell: UITableViewCell {

    // MARK: - Private UI
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showDescriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()

        //TODO: Need to reset all the properties here
    }

}

// MARK: - Configure

extension ShowDetailsHeaderCell {

    func configure(show: ShowLocal?) {
        showImageView.image = UIImage(named: "showImagePlaceholder")
        if let unwrappedNumberOfReviews = show?.numberOfReviews,
           let unwrappedAverageRating = show?.averageRating {
            
            ratingLabel.text = "\(unwrappedNumberOfReviews) REVIEWS, \(unwrappedAverageRating) AVERAGE"
        }
        showDescriptionLabel.text = show?.description
    }
}

