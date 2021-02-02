//
//  FMPMapVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/1/21.
//

import UIKit
import MapKit
import CoreLocation

class FMPMapVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let centerUserButton = FMPCenterOnUserButton()
    private let exitButton       = FMPExitButton()
    
    //MARK: - Properties
    
    private var mapView: MKMapView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureMapView() {
        mapView                     = MKMapView()
        mapView.delegate            = self
        mapView?.showsUserLocation  = true
        mapView?.userTrackingMode   = .followWithHeading
        
        view.addSubview(mapView)
        mapView.frame               = view.bounds
        
    }
    
    
    private func configureUI() {
        
        
    }
    
    
}

//MARK: - MapViewDelegate

extension FMPMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //do stuff when the annotation is selected
    }
    
}
