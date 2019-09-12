//
//  VenueDetailModel.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol VenueDetailModelLogic {
    func fetchVenueDetail()
    func getVenueDetail() -> VenueDetail?
}

protocol VenueDetailDataStore {
	var id: String { get set }
    var name: String { get set }
    var location: String { get set }
    var image: String? { get set }
}

class VenueDetailModel: VenueDetailModelLogic, VenueDetailDataStore {
	var service: VenueDetailServiceLogic?
	weak var presenter: VenueDetailPresentationModelLogic?
    var id: String = ""
    var name: String = ""
    var location: String = ""
    var image: String?
    var venue: VenueDetail?

    func fetchVenueDetail() {
        service?.fetchVenue(id: self.id, callback: { [weak self] response in
            guard let response = response else {
                return
            }
            self?.venue = response.response.venue
            self?.presenter?.presentVenue()
        })
    }

    func getVenueDetail() -> VenueDetail? {
        return self.venue
    }
}
