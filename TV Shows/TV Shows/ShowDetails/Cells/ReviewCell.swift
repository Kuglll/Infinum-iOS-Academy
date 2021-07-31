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
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()

        //TODO: Need to reset all the properties here
    }

}

// MARK: - Configure

extension ReviewCell {

    func configure(review: Review?) {
        userPhotoImageView.image = UIImage(named: "showImagePlaceholder")
        usernameLabel.text = "test.user"
        commentLabel.text = "a simple comment"
    }
}


