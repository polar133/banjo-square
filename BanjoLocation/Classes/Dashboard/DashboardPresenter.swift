//
//  DashboardPresenter.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

public protocol DashboardParametersLogic {
	//Here goes the func that receive data as params if needed to be saved in DataStore.
}

protocol DashboardPresentationLogic {
}

protocol DashboardPresentationModelLogic: class {
    func updateVenues()
    func presentError()
}

class DashboardPresenter: DashboardPresentationLogic, DashboardPresentationModelLogic, DashboardParametersLogic {

	weak var view: DashboardDisplayLogic?
	var model: (DashboardModelLogic & DashboardDataStore)?

    func updateVenues() {
    }

    func presentError() {
        
    }
}
