//
//  VenueDetailViewController.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol VenueDetailDisplayLogic: class {
}

public class VenueDetailViewController: UIViewController, VenueDetailDisplayLogic {
	var presenter: VenueDetailPresentationLogic?
	public var params: VenueDetailParametersLogic?

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
	}
}
