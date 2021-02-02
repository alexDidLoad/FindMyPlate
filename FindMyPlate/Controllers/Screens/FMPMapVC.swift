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
    
    private let centerUserButton    = FMPCenterOnUserButton()
    private let exitButton          = FMPExitButton()
    
    private let resultContainerView = FMPMapResultsContainerView()
    
    //MARK: - Properties
    
    private var mapView: MKMapView!
    private var mapAnnotation: MKPointAnnotation!
    
    private var containerViewOrigin: CGPoint!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addPanGesture(to: resultContainerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        centerOnUserLocation(shouldLoadAnnotations: true)
    }
    
    //MARK: - Helpers
    
    private func addPanGesture(to view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(FMPMapVC.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    
    private func configureUI() {
        configureMapView()
        configureButtons()
        configureResultView()
    }
    
    
    private func configureResultView() {
        view.addSubview(resultContainerView)
        resultContainerView.backgroundColor = .white
        resultContainerView.anchor(leading: view.leadingAnchor,
                                   bottom: view.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   paddingBottom: -(view.frame.height - 88),
                                   height: view.frame.height)
        
//        containerViewOrigin = resultContainerView.frame.origin
    }
    
    
    private func configureMapView() {
        mapView                     = MKMapView()
        mapView.delegate            = self
        mapView?.showsUserLocation  = true
        mapView?.userTrackingMode   = .followWithHeading
        
        view.addSubview(mapView)
        mapView.frame               = view.bounds
    }
    
    
    private func configureButtons() {
        centerUserButton.delegate = self
        exitButton.delegate       = self
        
        view.addSubview(centerUserButton)
        centerUserButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                trailing: view.trailingAnchor,
                                paddingTop: 30,
                                paddingTrailing: 16,
                                height: 50,
                                width: 50)
        
        view.addSubview(exitButton)
        exitButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.safeAreaLayoutGuide.leadingAnchor,
                          paddingTop: 8,
                          paddingLeading: 16)
    }
    
    //MARK: - Selectors
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let containerView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            containerView.center = CGPoint(x: containerView.center.x,
                                           y: containerView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
           
            if containerView.center.y < 570.0 {
                containerView.center.y = 570.0
            } else if containerView.center.y > 1178.0 {
                containerView.center.y = 1178.0
            }
            
        case .ended:
            //set the state of the view in here in order to snap it into place
            
            break
        case .possible, .cancelled, .failed:
            break
        @unknown default:
            break
        }
    }
    
    //MARK: - MapKit Helpers
    
    private func centerOnUserLocation(shouldLoadAnnotations: Bool) {
        guard let coordinate = LocationManager.shared.location?.coordinate else { return }
        let region           = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)
        
        //            if shouldLoadAnnotations {
        //                loadRestaurantNumbers(withSearchQuery: foodCategory)
        //            }
        mapView.setRegion(region, animated: true)
        //            mapSearchView.expansionState = .NotExpanded
    }
    
}
//MARK: - MapViewDelegate

extension FMPMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //do stuff when the annotation is selected
    }
    
}

//MARK: - ButtonDelegates

extension FMPMapVC: FMPCenterOnUserButtonDelegate, FMPExitButtonDelegate {
    
    func didPressCenter() {
        centerOnUserLocation(shouldLoadAnnotations: false)
    }
    
    
    func didPressExit() {
        dismiss(animated: true)
    }
}





