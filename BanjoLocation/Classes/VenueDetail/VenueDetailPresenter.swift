//
//  VenueDetailPresenter.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

public protocol VenueDetailParametersLogic {
    func setVenueParams(id: String, name: String, location: String)
}

protocol VenueDetailPresentationLogic {
    func getVenue()
}

protocol VenueDetailPresentationModelLogic: class {
    func presentVenue()
}

class VenueDetailPresenter: VenueDetailPresentationLogic, VenueDetailPresentationModelLogic, VenueDetailParametersLogic {

	weak var view: VenueDetailDisplayLogic?
	var model: (VenueDetailModelLogic & VenueDetailDataStore)?

    func setVenueParams(id: String, name: String, location: String) {
        self.model?.id = id
        self.model?.name = name
        self.model?.location = location
    }

    func getVenue() {
        self.model?.fetchVenueDetail()
    }

    func presentVenue() {
        guard let venueDetailModel = self.model?.getVenueDetail() else {
            return
        }
        let photoURL = venueDetailModel.bestPhoto?.getPhoto() ?? venueDetailModel.photos?.getPhotos().randomElement()
        let venueDetail = VenueDetailViewModel(name: venueDetailModel.name,
                                               location: self.model?.location,
                                               imageURL: photoURL,
                                               phoneNumber: venueDetailModel.contact?.formattedPhone,
                                               url: venueDetailModel.url,
                                               price: venueDetailModel.price?.message,
                                               likes: "\(venueDetailModel.likes?.count ?? 0)",
                                               rating: "\(venueDetailModel.rating ?? 0)",
                                               ratingColor: venueDetailModel.ratingColor,
                                               photos: venueDetailModel.photos?.getPhotos())
        self.view?.configureContent(viewModel: venueDetail)
    }
}
