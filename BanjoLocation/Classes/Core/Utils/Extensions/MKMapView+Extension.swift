//
//  MKMapView+Extension.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/11/19.
//

import Foundation
import MapKit

extension MKMapView {
    func zoomToFitMapAnnotations() {
        guard !self.annotations.isEmpty else {
            return
        }
        var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
        var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)
        self.annotations.forEach {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, $0.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, $0.coordinate.latitude)

            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, $0.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, $0.coordinate.latitude)
        }
        let resd = CLLocationCoordinate2D(latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5, longitude: topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5)
        let span = MKCoordinateSpan(latitudeDelta: fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.3, longitudeDelta: fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.3)
        var region = MKCoordinateRegion(center: resd, span: span)
        region = self.regionThatFits(region)
        self.setRegion(region, animated: true)

    }
}
