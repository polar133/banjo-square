//
//  VenueDetailViewController.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SDWebImage

protocol VenueDetailDisplayLogic: class {
    func configureContent(viewModel: VenueDetailViewModel)
    func showErrorView()
}

public class VenueDetailViewController: UIViewController, VenueDetailDisplayLogic {
	var presenter: VenueDetailPresentationLogic?
	public var params: VenueDetailParametersLogic?

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var contentStackView: UIView!
    @IBOutlet private weak var photoImage: UIImageView!

    @IBOutlet private weak var errorView: UIView!

    //Content
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!

    @IBOutlet private weak var phoneView: UIView!
    @IBOutlet private weak var phoneLabel: UILabel!

    @IBOutlet private weak var webpageView: UIView!
    @IBOutlet private weak var webpageLabel: UILabel!

	// MARK: Object lifecycle
	init() {
		super.init(nibName: String(describing: VenueDetailViewController.self),
                   bundle: Bundle(for: VenueDetailViewController.classForCoder()))
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: View lifecycle

	override public func viewDidLoad() {
		super.viewDidLoad()
        self.configureView()
        self.presenter?.getVenue()
	}

    func configureView() {
        contentView.layer.cornerRadius = 12
        let origImage = UIImage(named: "Back")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = .white
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func showErrorView() {
        DispatchQueue.main.async { [weak self] in
            self?.errorView.isHidden = false
        }
    }

    func configureContent(viewModel: VenueDetailViewModel) {

        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = viewModel.name.capitalized
            self?.locationLabel.text = (viewModel.location ?? "").capitalized

            if let photoURL = viewModel.imageURL, !photoURL.isEmpty, let url = URL(string: photoURL) {
                self?.photoImage.sd_setImage(with: url, completed: nil)
            }

            self?.ratingLabel.text = viewModel.rating
            self?.likesLabel.text = "\(viewModel.likes ?? "0") Likes"

            if let phone = viewModel.phoneNumber {
                self?.phoneLabel.text = phone
            } else {
                self?.phoneView.isHidden = true
            }

            if let url = viewModel.url {
                self?.webpageLabel.text = url
            } else {
                self?.webpageView.isHidden = true
            }
        }
    }

}
