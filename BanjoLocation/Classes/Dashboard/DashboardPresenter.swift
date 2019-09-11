//
//  DashboardPresenter.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

typealias Coordinates = (lat: Double, lng: Double)

public protocol DashboardParametersLogic {
}

protocol DashboardPresentationLogic {
    func setFilterFor(position: Coordinates, radius: Int, section: String?)
    func updateLocation(position: Coordinates)
    func getAmountOfVenues() -> Int
    func getViewModelFor(index: Int) -> VenueViewModel?
}

protocol DashboardPresentationModelLogic: class {
    func updateVenues()
    func presentError()
}

class DashboardPresenter: DashboardPresentationLogic, DashboardPresentationModelLogic, DashboardParametersLogic {

	weak var view: DashboardDisplayLogic?
	var model: (DashboardModelLogic & DashboardDataStore)?
    var radius = 250
    var section: String?
    var farAway = false
    var isInsideRadius = false
    var position: Coordinates = (0.0, 0.0) {
        didSet {
            self.isInsideRadius = !isAwayOfRadius(oldPosition: oldValue, newPosition: self.position)
            self.farAway = isFarAway(oldPosition: oldValue, newPosition: self.position)
        }
    }

    func setFilterFor(position: Coordinates, radius: Int, section: String?) {
        self.position = position
        if radius != self.radius || section != self.section {
            self.radius = radius
            self.section = section
            self.model?.getVenues(lat: self.position.lat, lng: self.position.lng, radius: self.radius, section: self.section, clearVenues: self.farAway)
        }
    }

    func updateLocation(position: Coordinates) {
        self.position = position
        if !isInsideRadius {
            self.model?.getVenues(lat: self.position.lat, lng: self.position.lng, radius: self.radius, section: self.section, clearVenues: self.farAway)
        }
    }

    func updateVenues() {
        self.view?.updateView()
    }

    func presentError() {

    }

    func getViewModelFor(index: Int) -> VenueViewModel? {
        let elements = Array(self.model?.venuesAvailables() ?? [])
        guard elements.count > index else {
            return nil
        }
        let venue = elements[index]
        let viewModel = VenueViewModel(title: venue.name, location: venue.location.address ?? "", firstCategory: nil, secondCategory: nil)
        return viewModel
    }

    func getAmountOfVenues() -> Int {
        return self.model?.venuesAvailables().count ?? 0
    }

    private func isAwayOfRadius(oldPosition: Coordinates, newPosition: Coordinates) -> Bool {
        let distance = haversineDinstance(la1: oldPosition.lat, lo1: oldPosition.lng, la2: newPosition.lat, lo2: newPosition.lng)
        return Int(distance.rounded()) > self.radius
    }

    // checks if to far away from the previous position.
    private func isFarAway(oldPosition: Coordinates, newPosition: Coordinates) -> Bool {
        let distance = haversineDinstance(la1: oldPosition.lat, lo1: oldPosition.lng, la2: newPosition.lat, lo2: newPosition.lng)
        return Int(distance.rounded()) > self.radius * 10
    }
}
