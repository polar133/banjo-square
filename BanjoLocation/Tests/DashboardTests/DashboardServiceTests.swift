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

        //When
        service.fetchLocations(successHandler: { response in
            expectation.fulfill()
        }) { error in
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(venues)
    }

}
