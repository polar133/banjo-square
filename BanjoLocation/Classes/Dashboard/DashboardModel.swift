//
//  DashboardModel.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DashboardModelLogic {
    func getVenues(lat: Double, lng: Double, radius: Int, section: String?)
}

protocol DashboardDataStore {
}

class DashboardModel: DashboardModelLogic, DashboardDataStore {
	var service: DashboardServiceLogic?
	weak var presenter: DashboardPresentationModelLogic?
    var venues: Set<Venue> = []

    func getVenues(lat: Double, lng: Double, radius: Int, section: String?) {

    }

}
