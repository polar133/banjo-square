//
//  DashboardViewController.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation

protocol DashboardDisplayLogic: class {

}

public class DashboardViewController: UIViewController, DashboardDisplayLogic {
	var presenter: DashboardPresentationLogic?
	public var params: DashboardParametersLogic?
    let locationManager = CLLocationManager()
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!

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

        }
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension DashboardViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            self.presenter?.updateLocation(position: (Double(currentLocation.coordinate.latitude),
                                                      Double(currentLocation.coordinate.longitude)))
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
