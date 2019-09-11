//
//  VenueDetailModel.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol VenueDetailModelLogic {
}

protocol VenueDetailDataStore {
	//var name: String { get set }
}

class VenueDetailModel: VenueDetailModelLogic, VenueDetailDataStore {
	var service: VenueDetailServiceLogic?
	weak var presenter: VenueDetailPresentationModelLogic?
	//var name: String = ""
}
