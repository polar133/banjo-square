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

protocol DashboardPresentationLogic: class {
    func setFilterFor(radius: Int, section: String?)
    func updateLocation(position: Coordinates)
    func getAmountOfVenues() -> Int
    func getViewModelFor(index: Int) -> VenueViewModel?
    func presentVenueDetail(index: Int)
    func presentVenueDetail(title: String)
    func annotationSelected(title: String)
    func getRadius() -> Int
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

    func getRadius() -> Int {
        return self.radius
    }

    func setFilterFor(radius: Int, section: String?) {
        if radius != self.radius || section != self.section {
            self.radius = radius
            self.section = section
            self.model?.getVenues(lat: self.position.lat, lng: self.position.lng, radius: self.radius, section: self.section, clearVenues: false)
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
        for venue in self.model?.venuesAvailables() ?? [] {
            self.view?.addCustomAnnotation(title: venue.name, venue.location.lat, venue.location.lng)
        }
    }

    func presentError() {

    }

    func annotationSelected(title: String) {
        let elements = Array(self.model?.venuesAvailables() ?? [])
        for index in 0..<elements.count {
            if elements[index].name == title {
                self.view?.scrollTo(index: index)
                break
            }
        }
    }

    func presentVenueDetail(title: String) {
        let elements = Array(self.model?.venuesAvailables() ?? [])
        for index in 0..<elements.count {
            if elements[index].name == title {
                let vc = VenueDetailFactory().getVenueDetailViewController()
                let venue = elements[index]
                vc.params?.setVenueParams(id: venue.id, name: venue.name, location: venue.location.address ?? "")
                self.view?.navigateTo(viewController: vc)
                break
            }
        }
    }

    func presentVenueDetail(index: Int) {
        let elements = Array(self.model?.venuesAvailables() ?? [])
        guard elements.count > index else {
            return
        }
        let vc = VenueDetailFactory().getVenueDetailViewController()
        let venue = elements[index]
        vc.params?.setVenueParams(id: venue.id, name: venue.name, location: venue.location.address ?? "")
        self.view?.navigateTo(viewController: vc)
    }

    func getViewModelFor(index: Int) -> VenueViewModel? {
        let elements = Array(self.model?.venuesAvailables() ?? [])
        guard elements.count > index else {
            return nil
        }
        let venue = elements[index]
        var viewModel = VenueViewModel(title: venue.name, location: venue.location.address ?? "", firstCategory: nil, secondCategory: nil)
        if let category = venue.categories.first {
            let categoryVM = CategoryViewModel(title: category.shortName, url: category.getIconURL())
            viewModel.firstCategory = categoryVM
        }
        if venue.categories.count > 1 {
            let category = venue.categories[1]
            let categoryVM = CategoryViewModel(title: category.shortName, url: category.getIconURL())
            viewModel.secondCategory = categoryVM
        }
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
