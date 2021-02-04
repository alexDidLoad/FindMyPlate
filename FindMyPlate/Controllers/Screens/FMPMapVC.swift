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
    
    private var fmpTableVC: FMPMapResultsVC!
    
    private var mapView: MKMapView!
    private var mapAnnotation: MKPointAnnotation!
    
    private var restaurants: [Restaurant]!
    private var selectedFood: String!
    
    //MARK: - Init
    
    init(selectedFood: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.selectedFood       = selectedFood
        fmpTableVC = FMPMapResultsVC(selectedFood: selectedFood)
        fmpTableVC.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addPanGesture(to: resultContainerView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        centerOnUserLocation()
    }
    
    //MARK: - Helpers
    
    
    private func animate(containerView view: UIView) {
        
        let noExpansionY: CGFloat       = 1178.0
        let partialExpansionY: CGFloat  = 960.0
        let fullExpansionY: CGFloat     = 570.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: .zero, options: .curveEaseInOut) {
            if view.center.y > fullExpansionY + 175 {
                if view.center.y > partialExpansionY + 125 {
                    view.center.y = noExpansionY
                    self.fmpTableVC.tableView.isScrollEnabled = false
                } else {
                    view.center.y = partialExpansionY
                    self.fmpTableVC.tableView.isScrollEnabled = false
                }
            } else {
                view.center.y = fullExpansionY
                self.fmpTableVC.tableView.isScrollEnabled = true
            }
        }
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.anchor(top: containerView.topAnchor,
                            leading: containerView.leadingAnchor,
                            bottom: containerView.bottomAnchor,
                            trailing: containerView.trailingAnchor,
                            paddingTop: 42,
                            paddingBottom: 196)
        childVC.didMove(toParent: self)
    }
    
    
    private func addPanGesture(to view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(FMPMapVC.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    
    private func configureResultView() {
        
        resultContainerView.backgroundColor = .white
        
        view.addSubview(resultContainerView)
        resultContainerView.anchor(leading: view.leadingAnchor,
                                   bottom: view.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   paddingBottom: -(view.frame.height - 306),
                                   height: view.frame.height)
        
        add(childVC: fmpTableVC, to: self.resultContainerView)
    }
    
    
    private func configureMapView() {
        mapView                     = MKMapView()
        mapView.delegate            = self
        mapView?.showsUserLocation  = true
        mapView?.userTrackingMode   = .follow
        
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
    
    
    private func configureUI() {
        configureMapView()
        configureButtons()
        configureResultView()
    }
    
    //MARK: - Selectors
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let containerView = sender.view!
        let translation   = sender.translation(in: view)
        
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
            animate(containerView: containerView)
            
        case .possible, .cancelled, .failed:
            break
        @unknown default:
            break
        }
    }
    
    //MARK: - MapKit Helpers
    
    private func zoomToFit(selectedAnnotation: MKAnnotation?) {
        if mapView.annotations.count == 0 {
            return
        }
        var topLeftCoordinate = CLLocationCoordinate2D(latitude: -90, longitude: 180)
        var bottomRightCoordinate = CLLocationCoordinate2D(latitude: 90, longitude: -180)
        
        if let selectedAnnotation = selectedAnnotation {
            for annotation in mapView.annotations {
                if let userAnnotation = annotation as? MKUserLocation {
                    topLeftCoordinate.longitude     = fmin(topLeftCoordinate.longitude, userAnnotation.coordinate.longitude)
                    topLeftCoordinate.latitude      = fmax(topLeftCoordinate.latitude, userAnnotation.coordinate.latitude)
                    bottomRightCoordinate.longitude = fmax(bottomRightCoordinate.longitude, userAnnotation.coordinate.longitude)
                    bottomRightCoordinate.latitude  = fmin(bottomRightCoordinate.latitude, userAnnotation.coordinate.latitude)
                }
                if annotation.title == selectedAnnotation.title {
                    topLeftCoordinate.longitude     = fmin(topLeftCoordinate.longitude, annotation.coordinate.longitude)
                    topLeftCoordinate.latitude      = fmax(topLeftCoordinate.latitude, annotation.coordinate.latitude)
                    bottomRightCoordinate.longitude = fmax(bottomRightCoordinate.longitude, annotation.coordinate.longitude)
                    bottomRightCoordinate.latitude  = fmin(bottomRightCoordinate.latitude, annotation.coordinate.latitude)
                }
            }
            var region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(topLeftCoordinate.latitude - (topLeftCoordinate.latitude - bottomRightCoordinate.latitude) * 0.65, topLeftCoordinate.longitude + (bottomRightCoordinate.longitude - topLeftCoordinate.longitude) * 0.65), span: MKCoordinateSpan(latitudeDelta: fabs(topLeftCoordinate.latitude - bottomRightCoordinate.latitude) * 3.0, longitudeDelta: fabs(bottomRightCoordinate.longitude - topLeftCoordinate.longitude) * 3.0))
            
            region = mapView.regionThatFits(region)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    private func centerOnUserLocation() {
        
        guard let coordinate = LocationManager.shared.location?.coordinate else { return }
        let region           = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
        
        mapView.setRegion(region, animated: true)
    }
    
}
//MARK: - MapViewDelegates

extension FMPMapVC: MKMapViewDelegate, FMPMapResultsVCDelegate {
    
    func didSelectAnnotation(withMapItem mapItem: MKMapItem) {
        mapView.annotations.forEach({ annotation in
           
            if annotation.title != mapItem.name {
                self.mapView.removeAnnotation(annotation)
            } else {
                self.mapView.selectAnnotation(annotation, animated: true)
                self.zoomToFit(selectedAnnotation: annotation)
            }
        })
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: .zero, options: .curveEaseInOut) {
            self.resultContainerView.center.y = 960.0
        }
    }
    
    
    func addAnnotations(forRestaurants restaurants: [Restaurant]) {
        for restaurant in restaurants {
            guard let latitude = restaurant.latitude, let longitude = restaurant.longitude else { return }
            DispatchQueue.main.async {
                self.mapAnnotation                      = MKPointAnnotation()
                self.mapAnnotation.title                = restaurant.name
                self.mapAnnotation.coordinate.latitude  = latitude
                self.mapAnnotation.coordinate.longitude = longitude
                self.mapView.addAnnotation(self.mapAnnotation)
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //do stuff when the annotation is selected
    }
}

//MARK: - ButtonDelegates

extension FMPMapVC: FMPCenterOnUserButtonDelegate, FMPExitButtonDelegate {
    
    func didPressCenter() {
        centerOnUserLocation()
    }
    
    
    func didPressExit() {
        dismiss(animated: true)
    }
}





