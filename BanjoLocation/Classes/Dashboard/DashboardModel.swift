//
//  DashboardModel.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DashboardModelLogic {
    func getVenues(lat: Double, lng: Double, radius: Int, section: String?, clearVenues: Bool)
    func venuesAvailables() -> Set<Venue>
}

protocol DashboardDataStore {
}

class DashboardModel: DashboardModelLogic, DashboardDataStore {
	var service: DashboardServiceLogic?
	weak var presenter: DashboardPresentationModelLogic?
    var venues: Set<Venue> = []

    func getVenues(lat: Double, lng: Double, radius: Int, section: String?, clearVenues: Bool) {
        let position = "\(lat),\(lng)"
        service?.fetchLocations(position: position, radius: "\(radius)", section: section, callback: { [weak self] response in
            guard let venuesResponse = response else {
                self?.presenter?.presentError()
                return
            }
            let venuesList = venuesResponse.response.groups.compactMap { $0.items.compactMap { $0.venue } }.reduce([], +)
            if clearVenues {
                self?.venues = Set(venuesList)
            } else {
                venuesList.forEach { self?.venues.insert($0) }
            }
            self?.presenter?.updateVenues()
        })
    }

    func venuesAvailables() -> Set<Venue> {
        return self.venues
    }

}
