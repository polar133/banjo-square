//
//  VenueDetailModelTests.swift
//  BanjoLocation-Unit-Dashboard-Dashboard-UnitTests
//
//  Created by Carlos Jimenez on 9/11/19.
//

import XCTest
@testable import BanjoLocation

// swiftlint:disable all
class VenueDetailModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchVenueDetail() {
        //Given
        let model = VenueDetailModel()
        let service = VenueDetailServiceSpy()
        model.service = service
        model.venue = nil

        //When
        model.fetchVenueDetail()

        //Then
        XCTAssertTrue(service.fetchVenueCalled)
        XCTAssertNotNil(model.venue)
    }

    func testFetchVenueDetailError() {
        //Given
        let model = VenueDetailModel()
        let service = FakeVenueDetailServiceSpy()
        model.service = service
        model.venue = nil

        //When
        model.fetchVenueDetail()

        //Then
        XCTAssertTrue(service.fetchVenueCalled)
        XCTAssertNil(model.venue)
    }

    func testGetVenueDetail() {
        //Given
        let model = VenueDetailModel()
        let venuePreLoaded = VenueDetail(id: "123", name: "TEST", contact: nil, url: nil, price: nil, likes: nil, rating: nil, ratingColor: nil, photos: nil)
        model.venue = venuePreLoaded
        
        //When
        let venue = model.getVenueDetail()

        //Then
        XCTAssertEqual(venue?.id, venuePreLoaded.id)
        XCTAssertEqual(venue?.name, venuePreLoaded.name)
    }
}

class VenueDetailServiceSpy: VenueDetailServiceLogic {
    var fetchVenueCalled = false
    func fetchVenue(id: String, callback: @escaping (VenueDetailResponse?) -> Void) {
        fetchVenueCalled = true
        let bundle = Bundle(for: VenueDetailServiceTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "GET_venue_detail_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        let venueSerialized = try? JSONDecoder().decode(VenueDetailResponse.self, from: data!)
        callback(venueSerialized)
    }
}

class FakeVenueDetailServiceSpy: VenueDetailServiceLogic {
    var fetchVenueCalled = false
    func fetchVenue(id: String, callback: @escaping (VenueDetailResponse?) -> Void) {
        fetchVenueCalled = true
        callback(nil)
    }
}
