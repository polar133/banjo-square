//
//  VenueDetailPresenter.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

public protocol VenueDetailParametersLogic {
	//Here goes the func that receive data as params if needed to be saved in DataStore.
}

protocol VenueDetailPresentationLogic {
}

protocol VenueDetailPresentationModelLogic: class {
}

class VenueDetailPresenter: VenueDetailPresentationLogic, VenueDetailPresentationModelLogic, VenueDetailParametersLogic {

	weak var view: VenueDetailDisplayLogic?
	var model: (VenueDetailModelLogic & VenueDetailDataStore)?
}
