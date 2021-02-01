//
//  EnableLocationVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/30/21.
//

import UIKit
import CoreLocation

class EnableLocationVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let locationImageView: UIImageView = UIImageView(image: SFSymbols.locationIcon)
    private let enableLocationButton: FMPEnableLocationButton = {
        let button = FMPEnableLocationButton(frame: .zero)
        button.addTarget(self, action: #selector(enableButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helper
    
    private func handleDeniedAuth(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            presentFYPAlertVC(with: "Please Enable Locations", message: "Settings > Privacy > Location Services > Enable", manager: manager)
        }
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(locationImageView)
        locationImageView.setDimensions(height: 180, width: 210)
        locationImageView.centerInView(view: view)
        
        view.addSubview(enableLocationButton)
        enableLocationButton.anchor(top: locationImageView.bottomAnchor,
                                    leading: view.leadingAnchor,
                                    trailing: view.trailingAnchor,
                                    paddingTop: 50,
                                    paddingLeading: 50,
                                    paddingTrailing: 50,
                                    height: 50)
    }
    
    //MARK: - Selectors
    
    @objc private func enableButtonPressed() {
        LocationManager.shared.requestWhenInUseAuthorization()
        LocationManager.shared.delegate = self
        handleDeniedAuth(LocationManager.shared)
    }
    
}

//MARK: - CLLocationManagerDelegate

extension EnableLocationVC: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.location != nil else {
            presentFYPAlertVC(with: "Unable to find location", message: "Please try again")
            return
        }
        
        dismiss(animated: true)
    }
    
}
