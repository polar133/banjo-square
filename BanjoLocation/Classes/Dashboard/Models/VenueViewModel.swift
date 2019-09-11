//
//  VenueViewModel.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/11/19.
//

import Foundation

struct VenueViewModel {
    let title: String
    let location: String
    let firstCategory: CategoryViewModel?
    let secondCategory: CategoryViewModel?
}

struct CategoryViewModel {
    let title: String
    let url: String
}
