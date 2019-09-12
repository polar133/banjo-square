//
//  DashboardViewController.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol DashboardDisplayLogic: class {
    func updateView()
    func scrollTo(index: Int)
    func addCustomAnnotation(title: String, _ latitude: Double, _ longitude: Double) 
    func navigateTo(viewController: UIViewController)
}

public class DashboardViewController: UIViewController, DashboardDisplayLogic {
	var presenter: DashboardPresentationLogic?
	public var params: DashboardParametersLogic?
    let locationManager = CLLocationManager()

    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var locationStackView: UIStackView!

	// MARK: Object lifecycle
	init() {
        super.init(nibName: String(describing: DashboardViewController.self),
                   bundle: Bundle(for: DashboardViewController.classForCoder()))
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: View lifecycle

	override public func viewDidLoad() {
		super.viewDidLoad()
        configureCollection()
        let button = MKUserTrackingButton(mapView: self.mapView)
        locationStackView.addArrangedSubview(button)
	}

    func configureCollection() {
        self.collectionView.register(UINib(nibName: VenueCell.nibName, bundle: Bundle(for: DashboardViewController.self)), forCellWithReuseIdentifier: VenueCell.reuseIdentifier)
    }

    func updateView() {
        DispatchQueue.main.sync { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    @IBAction func getLocation(_ sender: Any) {
        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return

        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            return
        }
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
    }

    @IBAction func callFilter(_ sender: Any) {
        let vc = FilterViewController()
        vc.presenter = self.presenter
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }

    func addCustomAnnotation(title: String, _ latitude: Double, _ longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.title = title.capitalized
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
    }

    func scrollTo(index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }

    func navigateTo(viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
}

extension DashboardViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            self.presenter?.updateLocation(position: (Double(currentLocation.coordinate.latitude),
                                                      Double(currentLocation.coordinate.longitude)))
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width * 5) / 6, height: 180)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.calloutOffset = CGPoint(x: -5, y: 5)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        return annotationView
    }

    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationTitle = view.annotation?.title {
            self.presenter?.annotationSelected(title: annotationTitle ?? "")
        }
    }

    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotationTitle = view.annotation?.title {
            self.presenter?.presentVenueDetail(title: annotationTitle ?? "")
        }
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.getAmountOfVenues() ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.presentVenueDetail(index: indexPath.row)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VenueCell.reuseIdentifier, for: indexPath) as? VenueCell,
            let viewModel = self.presenter?.getViewModelFor(index: indexPath.row)
            else {
                return UICollectionViewCell()
        }

        cell.setupInformation(viewModel: viewModel)
        return cell
    }

}
