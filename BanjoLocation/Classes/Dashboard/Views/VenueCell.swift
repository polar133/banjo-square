//
//  VenueCell.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/11/19.
//

import UIKit

class VenueCell: UICollectionViewCell {

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!

    //Categories
    @IBOutlet private weak var firstCatView: UIView!
    @IBOutlet private weak var firstCatIconImage: UIImageView!
    @IBOutlet private weak var firstCatNameLabel: UILabel!

    @IBOutlet private weak var secCatView: UIView!
    @IBOutlet private weak var secCatIconImage: UIImageView!
    @IBOutlet private weak var secCatNameLabel: UILabel!

    static var nibName: String {
        return String(describing: self)
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.cardView.layer.cornerRadius = 20.0
        self.cardView.layer.shadowColor = UIColor.gray.cgColor
        self.cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.cardView.layer.shadowRadius = 6
        self.cardView.layer.shadowOpacity = 0.4
    }

    func setupInformation(viewModel: VenueViewModel) {
        self.titleLabel.text = viewModel.title.capitalized
        self.locationLabel.text = viewModel.location.capitalized

        if let category = viewModel.firstCategory {
            firstCatView.isHidden = false
            firstCatNameLabel.text = category.title
        } else {
            firstCatView.isHidden = true
        }

        if let category = viewModel.secondCategory {
            secCatView.isHidden = false
            secCatNameLabel.text = category.title
        } else {
            secCatView.isHidden = true
        }
    }

}
