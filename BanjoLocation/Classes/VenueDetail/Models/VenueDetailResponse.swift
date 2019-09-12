//
//  VenueDetailResponse.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/11/19.
//

import Foundation

struct VenueDetailResponse: Decodable {
    let response: VenueDetailInformation
}

struct VenueDetailInformation: Decodable {
    let venue: VenueDetail
}

struct VenueDetail: Decodable {
    let id: String
    let name: String
    let contact: Contact?
    let url: String?
    let price: Price?
    let likes: Like?
    let rating: Double?
    let ratingColor: String?
    let photos: Photos?
}

struct Contact: Decodable {
    let phone: String?
    let formattedPhone: String?
}

struct Price: Decodable {
    let message: String
}

struct Like: Decodable {
    let count: Int
}

struct Photos: Decodable {
    let groups: [PhotoGroup]

    func getPhotos() -> [String] {
        return self.groups.compactMap { $0.items.compactMap { "\($0.prefix)\($0.suffix)" } }.reduce([], +)
    }
}

struct PhotoGroup: Decodable {
    let items: [Photo]
}

struct Photo: Decodable {
    let id: String
    let prefix: String
    let suffix: String
}
