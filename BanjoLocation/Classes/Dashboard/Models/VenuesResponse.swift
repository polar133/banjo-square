//
//  VenuesResponse.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/10/19.
//

import Foundation

struct VenuesResponse: Decodable {
    let response: VenuesInformation
}

struct VenuesInformation: Decodable {
    let groups: [GroupsResponse]
}

struct GroupsResponse: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let venue: Venue
}

struct Venue: Decodable, Hashable {
    let id: String
    let name: String
    let location: Location
    let categories: [Category]

    static func == (lhs: Venue, rhs: Venue) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.location == rhs.location &&
            lhs.categories == rhs.categories
    }
}

struct Location: Decodable, Hashable {
    let address: String?
    let lat: Double
    let lng: Double
    let distance: Int?

    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.address == rhs.address &&
            lhs.lat == rhs.lat &&
            lhs.lng == rhs.lng &&
            lhs.distance == rhs.distance
    }
}

struct Category: Decodable, Hashable {
    let id: String
    let shortName: String
    let icon: Icon

    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id &&
            lhs.shortName == rhs.shortName &&
            lhs.icon == rhs.icon
    }
}

struct Icon: Decodable, Hashable {
    let prefix: String
    let suffix: String

    static func == (lhs: Icon, rhs: Icon) -> Bool {
        return lhs.prefix == rhs.prefix &&
            lhs.suffix == rhs.suffix
     }
}
