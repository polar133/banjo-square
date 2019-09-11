//
//  VenueDetailStubs.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/11/19.
//

import Foundation
import OHHTTPStubs
@testable import BanjoLocation

//swiftlint:disable all
class VenueDetailStubs {

    public func enableStubs() {
        OHHTTPStubs.removeAllStubs()
        let venueFile = "GET_venue_detail_200.json"
        stub(condition: pathMatches(VenueDetailAPI.venue)) { _ in
            return fixture(
                filePath: OHPathForFile(venueFile, type(of: self))!,
                status: 200,
                headers: [:]
            )
        }
    }

    public func enableErrorStubs() {
        OHHTTPStubs.removeAllStubs()
        let venueFile = "GET_venue_detail_400.json"
        stub(condition: pathMatches(VenueDetailAPI.venue)) { _ in
            return fixture(
                filePath: OHPathForFile(venueFile, type(of: self))!,
                status: 400,
                headers: [:]
            )
        }
    }

}
