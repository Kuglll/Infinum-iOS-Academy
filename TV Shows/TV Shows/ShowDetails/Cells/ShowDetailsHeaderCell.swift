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

    func configure() {
        ratingLabel.text = "10 outa 10"
        showDescriptionLabel.text = "very gooooood"
    }
}

