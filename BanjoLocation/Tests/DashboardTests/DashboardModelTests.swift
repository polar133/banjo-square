//
//  DashboardModelTests.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//

import XCTest
@testable import BanjoLocation

// swiftlint:disable all
class DashboardModelTests: XCTestCase {

    override func setUp() {
        //setUp
    }

    override func tearDown() {
        //tearDown
    }

    func testGetVenues() {
        //Given
        let model = DashboardModel()
        let service = DashboardServiceSpy()
        let presenter = DashboardPresenterSpy()
        model.service = service
        model.presenter = presenter
        let lat = -12.0
        let lng = 12.0

        //When
        model.getVenues(lat: lat, lng: lng, radius: 100, section: nil)

        //Then
        XCTAssertFalse(model.venues.isEmpty)
        XCTAssertTrue(service.fetchLocationsCalled)
        XCTAssertTrue(presenter.updateVenuesCalled)
    }

}

class DashboardPresenterSpy: DashboardPresentationModelLogic {
    var updateVenuesCalled = false

    func updateVenues() {
        updateVenuesCalled = true
    }
}

class DashboardServiceSpy: DashboardServiceLogic {
    var fetchLocationsCalled = false

    func fetchLocations(position: String, radius: String, section: String?, callback: @escaping (VenuesResponse?) -> Void) {
        fetchLocationsCalled = true

        let bundle = Bundle(for: DashboardServiceTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "GET_venues_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        let venuesSerialized = try? JSONDecoder().decode(VenuesResponse.self, from: data!)
        callback(venuesSerialized)
    }


}
