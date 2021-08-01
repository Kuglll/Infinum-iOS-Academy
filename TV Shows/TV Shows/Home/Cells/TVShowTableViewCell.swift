//
//  TVShowTableViewCell.swift
//  TV Shows
//
//  Created by Mark Frelih on 30.07.2021..
//

import Foundation
import UIKit

final class TVShowTableViewCell: UITableViewCell {

    // MARK: - Private UI
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        showImageView.image = nil
    }

}

// MARK: - Configure

extension TVShowTableViewCell {

    func configure(with item: ShowLocal?) {
        if let unwrappedTitle = item?.title{
            titleLabel.text = unwrappedTitle
        }
        showImageView.image = UIImage(named: "showImagePlaceholder")
    }
}
