//
//  DashboardPresenterTests.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/10/19.
//

import XCTest
@testable import BanjoLocation

// swiftlint:disable all
class DashboardPresenterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetFilter() {
        //Given
        let presenter = DashboardPresenter()
        presenter.position = (1.0, 1.0)
        presenter.radius = 250
        presenter.section = "Picks"
        let model = DashboardModelSpy()
        presenter.model = model

        //When
        presenter.setFilterFor(radius: 1000, section: "TEST")

        //Then
        XCTAssertEqual(presenter.radius, 1000)
        XCTAssertEqual(presenter.position.lat, 1.0)
        XCTAssertEqual(presenter.position.lng, 1.0)
        XCTAssertEqual(presenter.section, "TEST")
        XCTAssertTrue(model.getVenuesCalled)
    }

    func testSetFilterEqualRadius() {
        //Given
        let presenter = DashboardPresenter()
        presenter.position = (1.0, 1.0)
        presenter.radius = 250
        presenter.section = "Picks"

        //When
        presenter.setFilterFor(radius: 250, section: "TEST")

        //Then
        XCTAssertEqual(presenter.position.lat, 1.0)
        XCTAssertEqual(presenter.position.lng, 1.0)
        XCTAssertEqual(presenter.radius, 250)
        XCTAssertEqual(presenter.section, "TEST")
        XCTAssertTrue(presenter.farAway)
    }

    func testSetFilterEqualSection() {
        //Given
        let presenter = DashboardPresenter()
        let model = DashboardModelSpy()
        presenter.position = (1.0, 1.0)
        presenter.radius = 250
        presenter.section = nil
        presenter.model = model

        //When
        presenter.setFilterFor(radius: 250, section: nil)

        //Then
        XCTAssertEqual(presenter.position.lat, 1.0)
        XCTAssertEqual(presenter.position.lng, 1.0)
        XCTAssertEqual(presenter.radius, 250)
        XCTAssertNil(presenter.section)
        XCTAssertFalse(model.getVenuesCalled)
    }

    func testLoadVenues() {
        //Given
        let presenter = DashboardPresenter()
        let model = DashboardModelSpy()
        presenter.model = model

        //When
        presenter.updateLocation(position: (200.0, 200.0))

        //Then
        XCTAssertTrue(model.getVenuesCalled)
    }

    func testLoadVenuesWithSameLocation() {
        //Given
        let presenter = DashboardPresenter()
        let model = DashboardModelSpy()
        presenter.model = model
        presenter.position = (200.0, 200.0)

        //When
        presenter.updateLocation(position: (200.0, 200.0))

        //Then
        XCTAssertFalse(presenter.farAway)
        XCTAssertFalse(model.getVenuesCalled)
    }

    func testLoadVenuesNearLocation() {
        //Given
        let presenter = DashboardPresenter()
        let model = DashboardModelSpy()
        presenter.model = model
        presenter.position = (40.741899, -73.989316)

        //When
        presenter.updateLocation(position: (40.741898,-73.989317))

        //Then
        XCTAssertFalse(presenter.farAway)
        XCTAssertFalse(model.getVenuesCalled)
    }

    func testUpdateVenues() {
        //Given

        //When

        //Then
    }

    func testPresentError() {
        //Given

        //When

        //Thenç
    }
}

class DashboardViewControllerSpy: DashboardDisplayLogic {

    var addCustomAnnotationCalled = false
    var scrollToCalled = false
    var navigateToCalled = false
    var updateViewCalled = false
    
    func updateView() {
        updateViewCalled = true
    }

    func navigateTo(viewController: UIViewController) {
        navigateToCalled = true
    }

    func scrollTo(index: Int) {
        scrollToCalled = true
    }

    func addCustomAnnotation(title: String, _ latitude: Double, _ longitude: Double) {
        addCustomAnnotationCalled = true
    }
}

class DashboardModelSpy: DashboardModelLogic, DashboardDataStore {
    var getVenuesCalled = false
    var venuesAvailablesCalled = false

    func getVenues(lat: Double, lng: Double, radius: Int, section: String?, clearVenues: Bool) {
        getVenuesCalled = true
    }

    func venuesAvailables() -> Set<Venue> {
        venuesAvailablesCalled = true
        return []
    }
}
