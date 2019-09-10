//
//  DashboardModel.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DashboardModelLogic {
}

protocol DashboardDataStore {
	//var name: String { get set }
}

class DashboardModel: DashboardModelLogic, DashboardDataStore {
	var service: DashboardServiceLogic?
	weak var presenter: DashboardPresentationModelLogic?
	//var name: String = ""
}
