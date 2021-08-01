//
//  ReviewCell.swift
//  TV Shows
//
//  Created by Mark Frelih on 31.07.2021..
//

import Foundation
import UIKit

final class ReviewCell: UITableViewCell {

    // MARK: - Private UI
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()

        usernameLabel.text = nil
        commentLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ratingView.configure(withStyle: .small)
        ratingView.isEnabled = false
    }

}

// MARK: - Configure

extension ReviewCell {

    func configure(review: Review?) {
        userPhotoImageView.image = UIImage(named: "ic-profile-placeholder")
        usernameLabel.text = review?.user.email
        commentLabel.text = review?.comment
        ratingView.setRoundedRating(Double(review?.rating ?? 0))
    }
}


