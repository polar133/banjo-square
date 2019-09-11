//
//  DashboardService.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum DashboardAPI {
    static let venues = "/venues/explore"
}

protocol DashboardServiceLogic: class {
    func fetchLocations(successHandler: @escaping (VenuesResponse) -> Void, errorHandler: @escaping (Error?) -> Void)
}

class DashboardService: DashboardServiceLogic {
    func fetchLocations(successHandler: @escaping (VenuesResponse) -> Void, errorHandler: @escaping (Error?) -> Void) {

    }
}
