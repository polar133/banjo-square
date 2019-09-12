//
//  VenueDetailServiceTests.swift
//  BanjoLocation-Unit-Dashboard-Dashboard-UnitTests
//
//  Created by Carlos Jimenez on 9/11/19.
//

import XCTest
@testable import BanjoLocation

// swiftlint:disable all
class VenueDetailServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchLocations() {
        //Given
        VenueDetailStubs().enableStubs()

        let service = VenueDetailService()
        var venueDetail: VenueDetailResponse?
        let expectation = self.expectation(description: "Fetch venue")

        let bundle = Bundle(for: VenueDetailServiceTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "GET_venue_detail_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        let venueSerialized = try? JSONDecoder().decode(VenueDetailResponse.self, from: data!)

        //When
        service.fetchVenue(id: "1234567") { response in
            venueDetail = response
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(venueDetail!)
        XCTAssertEqual(venueDetail!.response.venue.name, venueSerialized?.response.venue.name)
    }

    func testFetchLocationsFailed() {
        //Given
        VenueDetailStubs().enableErrorStubs()

        let service = VenueDetailService()
        var venueDetail: VenueDetailResponse?
        let expectation = self.expectation(description: "Fetch venue")

        //When
        service.fetchVenue(id: "1234567") { response in
            venueDetail = response
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(venueDetail == nil)
    }

}
