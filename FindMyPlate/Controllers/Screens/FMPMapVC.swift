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
    
    private let fmpTableVC = FMPMapResultsVC()
    
    private var mapView: MKMapView!
    private var mapAnnotation: MKPointAnnotation!
    
    private var restaurantNumber: [String]! { didSet { fetchRestaurants() } }
    private var selectedFood: String!
    
    //MARK: - Init
    
    init(selectedFood: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.selectedFood = selectedFood
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
        
        
        centerOnUserLocation(shouldLoadAnnotations: true)
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
    
    private func fetchRestaurants() {
        restaurantNumber.forEach { number in NetworkManager.shared.requestYelpData(withPhoneNumber: number) }
    }
    
    
    private func loadRestaurantPhoneNumbers(withSearchQuery query: String) {
        guard let userLocation = LocationManager.shared.location?.coordinate else { return }
        let region             = MKCoordinateRegion(center: userLocation, latitudinalMeters: 100, longitudinalMeters: 100)
        var phoneNumbers       = [String]()
        
        searchBy(naturalLanguageQuery: query, region: region, coordinates: userLocation) { [weak self] (response, error) in
            guard let self     = self else { return }
            guard let response = response else { return }
            
            response.mapItems.forEach({ mapItem in phoneNumbers.append(self.getMapItemPhoneNumber(mapItem)) })
            DispatchQueue.main.async { self.restaurantNumber = phoneNumbers }
        }
    }
    
    
    private func searchBy(naturalLanguageQuery: String, region: MKCoordinateRegion, coordinates: CLLocationCoordinate2D, completion: @escaping(_ response: MKLocalSearch.Response?, _ error: NSError?) -> Void) {
        
        let request                  = MKLocalSearch.Request()
        request.region               = region
        request.naturalLanguageQuery = naturalLanguageQuery
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response else {
                completion(nil, error! as NSError)
                return
            }
            
            completion(response, nil)
        }
    }
    
    
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





