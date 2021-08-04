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
    @IBOutlet private weak var showImageView: UIImageView!
    @IBOutlet private weak var showDescriptionLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingView: RatingView!
    
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()

        ratingLabel.text = nil
        showDescriptionLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.configure(withStyle: .large)
        ratingView.isEnabled = false
        configureImageView()
    }

}

// MARK: - Configure

extension ShowDetailsHeaderCell {

    func configure(show: ShowLocal?) {
        showImageView.image = UIImage(named: "showImagePlaceholder")
        if let numberOfReviews = show?.numberOfReviews,
           let averageRating = show?.averageRating {
            
            ratingLabel.text = "\(numberOfReviews) REVIEWS, \(averageRating) AVERAGE"
        }
        showDescriptionLabel.text = show?.description
        ratingView.setRoundedRating(Double(show?.averageRating ?? 0))
    }
    
    func configureImageView(){
        showImageView.layer.cornerRadius = 15.0
    }
}

