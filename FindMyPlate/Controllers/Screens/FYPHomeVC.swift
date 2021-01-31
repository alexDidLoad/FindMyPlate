//
//  FYPHomeVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/29/21.
//

import UIKit
import CoreLocation

class FYPHomeVC: UIViewController {
    
    //MARK: - UIComponents
    
    //MARK: - Properties
    
    var locationManager = CLLocationManager()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableLocationServices()
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
}

//MARK: - CLLocationManagerDelegate

extension FYPHomeVC: CLLocationManagerDelegate {
    
    func enableLocationServices() {
        locationManager.delegate                = self
        
        let enableLocationVC                    = EnableLocationVC()
        enableLocationVC.modalPresentationStyle = .fullScreen
       
        switch locationManager.authorizationStatus {
        
        case .notDetermined:
            DispatchQueue.main.async {
                enableLocationVC.locationManager = self.locationManager
                self.present(enableLocationVC, animated: true)
            }
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("always authorized")
        case .authorizedWhenInUse:
            print("only when in use")
        @unknown default:
            print("unknown case")
        }
        
    }
    
}
