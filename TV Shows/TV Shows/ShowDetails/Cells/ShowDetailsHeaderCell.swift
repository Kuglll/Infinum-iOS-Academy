//
//  ShowDetailsHeaderCell.swift
//  TV Shows
//
//  Created by Mark Frelih on 31.07.2021..
//

import Foundation
import UIKit
import Kingfisher

final class ShowDetailsHeaderCell: UITableViewCell {

    // MARK: - Private UI
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showDescriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()

        ratingLabel.text = nil
        showDescriptionLabel.text = nil
        showImageView.image = nil
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
        if let unwrappedNumberOfReviews = show?.numberOfReviews,
           let unwrappedAverageRating = show?.averageRating {
            ratingLabel.text = "\(unwrappedNumberOfReviews) REVIEWS, \(unwrappedAverageRating) AVERAGE"
        }
        showDescriptionLabel.text = show?.description
        ratingView.setRoundedRating(Double(show?.averageRating ?? 0))
        
        if let unwrappedShowImageUrl = show?.imageUrl{
            showImageView.kf.setImage(with: unwrappedShowImageUrl, placeholder: UIImage(named: "ic-show-placeholder-rectangle"))
        }
    }
    
    func configureImageView(){
        showImageView.layer.cornerRadius = 15.0
    }
}

