//
//  DashboardViewController.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DashboardDisplayLogic: class {
}

public class DashboardViewController: UIViewController, DashboardDisplayLogic {
	var presenter: DashboardPresentationLogic?
	public var params: DashboardParametersLogic?

	// MARK: Object lifecycle
	init() {
        super.init(nibName: String(describing: DashboardViewController.self),
                   bundle: Bundle(for: DashboardViewController.classForCoder()))
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
