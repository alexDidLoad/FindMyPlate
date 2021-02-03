//
//  EnableLocationVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/30/21.
//

import UIKit
import Lottie
import CoreLocation

class EnableLocationVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let animationView = AnimationView(name: Lottie.locationIcon)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView.play()
        animationView.loopMode = .loop
    }
    
    //MARK: - Helper
    
    private func handleDeniedAuth(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            presentFYPAlertVC(with: "Please Enable Locations", message: "Settings > Privacy > Location Services > Enable", manager: manager)
        }
    }
    
    
    private func configureUI() {
        
        view.backgroundColor = .white
        let padding: CGFloat = 50
        
        view.addSubview(animationView)
        animationView.centerX(inView: view)
        animationView.anchor(top: view.topAnchor,
                             paddingTop: 30)
        
        animationView.addSubview(enableLocationButton)
        enableLocationButton.anchor(leading: view.leadingAnchor,
                                    bottom: animationView.bottomAnchor,
                                    trailing: view.trailingAnchor,
                                    paddingLeading: padding,
                                    paddingBottom: 30,
                                    paddingTrailing: padding,
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
        if manager.authorizationStatus == .authorizedWhenInUse {
            dismiss(animated: true)
        } else {
            handleDeniedAuth(LocationManager.shared)
        }
    }
    
}
