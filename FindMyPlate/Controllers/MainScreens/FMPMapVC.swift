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
        fmpTableVC              = FMPMapResultsVC(selectedFood: selectedFood)
        fmpTableVC.delegate     = self
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
    
    private func addPanGesture(to view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(FMPMapVC.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    
    private func animate(containerView view: UIView) {
        let collapsed: CGFloat          = DeviceTypes.isiPhoneSE ? 950 : 1178
        let partiallyExpanded: CGFloat  = DeviceTypes.isiPhoneSE ? 800 : 960
        let fullyExpanded: CGFloat      = DeviceTypes.isiPhoneSE ? 510 : 570
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: .zero, options: .curveEaseInOut) {
            if view.center.y > fullyExpanded + 175 {
                if view.center.y > partiallyExpanded + 125 {
                    view.center.y = collapsed
                    self.fmpTableVC.tableView.isScrollEnabled = false
                } else {
                    view.center.y = partiallyExpanded
                    self.fmpTableVC.tableView.isScrollEnabled = false
                }
            } else {
                view.center.y = fullyExpanded
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
    
    
    private func configureResultView() {
        let bottomPaddingConstant: CGFloat = DeviceTypes.isiPhoneSE ? 200 : 306
        resultContainerView.backgroundColor = .white
        
        view.addSubview(resultContainerView)
        resultContainerView.anchor(leading: view.leadingAnchor,
                                   bottom: view.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   paddingBottom: -(view.frame.height - bottomPaddingConstant),
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
        
        let maxYConstant: CGFloat = DeviceTypes.isiPhoneSE ? 510 : 570
        let minYConstant: CGFloat = DeviceTypes.isiPhoneSE ? 950 : 1178
        
        switch sender.state {
        case .began, .changed:
            containerView.center = CGPoint(x: containerView.center.x, y: containerView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            
            if containerView.center.y < maxYConstant {
                containerView.center.y = maxYConstant
            } else if containerView.center.y > minYConstant {
                containerView.center.y = minYConstant
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
        if mapView.annotations.count == 0 { return }
        zoomToFocusOn(selectedAnnotation: selectedAnnotation, mapView: mapView)
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
            self.resultContainerView.center.y = DeviceTypes.isiPhoneSE ? 800 : 960
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
        zoomToFit(selectedAnnotation: view.annotation)
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






