//
//  FilterViewController.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/11/19.
//

import UIKit

class FilterViewController: UIViewController {
    weak var presenter: DashboardPresentationLogic?

    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var filterView: UIView!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var radiusSelectedLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!

    var radiusSelected: Float = 250

    // MARK: Object lifecycle
    init() {
        super.init(nibName: String(describing: FilterViewController.self),
                   bundle: Bundle(for: FilterViewController.classForCoder()))
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: View lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1.2) { [weak self] in
            self?.backgroundView.alpha = 0.45
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView.alpha = 0.0
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        configureCancel()
        configureFilter()
        configureSlider()
    }

    func configureCancel() {
        cancelButton.layer.cornerRadius = 12
        cancelButton.addTarget(self, action: #selector(dismissCurrentView), for: .touchUpInside)
    }

    func configureFilter() {
        filterView.layer.cornerRadius = 12
    }

    func configureSlider() {
        radiusSelected = Float(self.presenter?.getRadius() ?? 250)
        let currentValue = Int(radiusSelected)
        radiusSelectedLabel.text = "\(currentValue) meters"
        slider.setValue(radiusSelected, animated: true)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        radiusSelectedLabel.text = "\(currentValue) meters"
        radiusSelected = sender.value
    }

    @IBAction func dismissCurrentView(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.backgroundView.alpha = 0.0
        }) { [weak self] completed in
            if completed {
                self?.presenter?.setFilterFor(radius: Int(self?.radiusSelected ?? 250), section: nil)
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
