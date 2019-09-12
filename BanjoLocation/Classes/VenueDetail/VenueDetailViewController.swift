//
//  VenueDetailViewController.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol VenueDetailDisplayLogic: class {
    func configureContent(viewModel: VenueDetailViewModel)
}

public class VenueDetailViewController: UIViewController, VenueDetailDisplayLogic {
	var presenter: VenueDetailPresentationLogic?
	public var params: VenueDetailParametersLogic?

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var photoImage: UIImageView!

    //Content
    @IBOutlet private weak var titleLabel: UILabel!

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

    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func configureContent(viewModel: VenueDetailViewModel) {
        DispatchQueue.main.sync { [weak self] in
            self?.titleLabel.text = viewModel.name
        }
    }

}
