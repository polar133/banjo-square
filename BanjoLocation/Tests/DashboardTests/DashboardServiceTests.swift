//
//  DashboardServiceTests.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//

import XCTest
@testable import BanjoLocation

// swiftlint:disable all
class DashboardServiceTests: XCTestCase {

    override func setUp() {
        //setUp
    }

    override func tearDown() {
        //tearDown
    }

    func testFetchLocations() {
        //Given
        DashboardStubs().enableStubs()

        let service = DashboardService()
        var venues: VenuesResponse?
        let expectation = self.expectation(description: "Fetch venues")

        let bundle = Bundle(for: DashboardServiceTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "GET_venues_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        let venuesSerialized = try? JSONDecoder().decode(VenuesResponse.self, from: data!)
        let amountOfVenues = venuesSerialized!.response.groups.count

        //When
        service.fetchLocations(position: "40.74224,-73.99386", radius: "250", section: nil) { response in
            venues = response
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(venues!)
        XCTAssertEqual(venues!.response.groups.count, amountOfVenues)
    }

    func testFetchLocationsFailed() {
        //Given
        DashboardStubs().enableErrorStubs()

        let service = DashboardService()
        var venues: VenuesResponse?
        let expectation = self.expectation(description: "Fetch venues")

        //When
        service.fetchLocations(position: "40.74224,-73.99386", radius: "250", section: nil) { response in
            venues = response
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(venues == nil)
    }
}
