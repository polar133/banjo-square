//
//  VenueDetailService.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum VenueDetailAPI {
    static let venue = "/venues/"
}

protocol VenueDetailServiceLogic: class {
    func fetchVenue(id: String, callback: @escaping (VenueDetailResponse?) -> Void)
}

class VenueDetailService: VenueDetailServiceLogic {
    func fetchVenue(id: String, callback: @escaping (VenueDetailResponse?) -> Void) {
        
    }
}
