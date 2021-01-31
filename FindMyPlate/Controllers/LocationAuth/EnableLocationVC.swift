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
    private let enableLocationButton: FYPEnableLocationButton = {
        let button = FYPEnableLocationButton(frame: .zero)
        button.addTarget(self, action: #selector(enableButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    var locationManager: CLLocationManager!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helper
    
    private func handleDeniedAuth(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            let alert = UIAlertController(title: "Need Authorization", message: "This app is unusable if you don't authorize this app to use your location!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                let url = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }))
            self.present(alert, animated: true, completion: nil)
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
        
        print("Button pressed")
    }
    
}
