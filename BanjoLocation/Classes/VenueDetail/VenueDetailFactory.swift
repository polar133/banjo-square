//
//  VenueDetailFactory.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

@objc public class VenueDetailFactory: NSObject {
    @objc public override init() { }

    @objc public func getVenueDetailViewController() -> VenueDetailViewController {
        let viewController = VenueDetailViewController()
        let presenter = VenueDetailPresenter()
        let service = VenueDetailService()
        let model = VenueDetailModel()
        viewController.presenter = presenter
        viewController.params = presenter
        presenter.view = viewController
        presenter.model = model
        model.service = service
        model.presenter = presenter
        return viewController
    }
}