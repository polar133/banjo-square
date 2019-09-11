//
//  DashboardStubs.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/10/19.
//

import Foundation
import OHHTTPStubs
@testable import BanjoLocation

//swiftlint:disable all
class DashboardStubs {

    public func enableStubs() {

        let venuesFile = "GET_venues_200.json"
        stub(condition: pathMatches(DashboardAPI.venues)) { _ in
            return fixture(
                filePath: OHPathForFile(venuesFile, type(of: self))!,
                status: 200,
                headers: [:]
            )
        }
    }

}
