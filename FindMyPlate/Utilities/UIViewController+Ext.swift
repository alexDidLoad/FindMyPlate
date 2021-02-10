//
//  UIViewController+Ext.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit
import MapKit
import CoreLocation
import SafariServices

extension UIViewController {
    
    func presentFMPAlertVC(withTitle title: String, message: String, manager: CLLocationManager? = nil) {
        let alertVC = FMPAlertVC(title: title, message: message, manager: manager)
        alertVC.modalTransitionStyle     = .crossDissolve
        alertVC.modalPresentationStyle   = .overFullScreen
        
        DispatchQueue.main.async { self.present(alertVC, animated: true) }
    }
    
    
    func presentFMPFavoriteVC(withTitle title: String, message: String, restaurant: Restaurant, button: FMPFavoriteButton) {
        let alertVC = FMPFavoriteAlertVC(title: title, message: message, forRestaurant: restaurant, button: button)
        alertVC.modalTransitionStyle    = .crossDissolve
        alertVC.modalPresentationStyle  = .overFullScreen
        
        DispatchQueue.main.async { self.present(alertVC, animated: true) }
    }
    
    
    func getMapItemPhoneNumber(_ item: MKMapItem) -> String {
        let unwantedChars: Set<Character> = ["(", ")", "-"]
        var mapNumber = item.phoneNumber?.replacingOccurrences(of: " ", with: "")
        mapNumber?.removeAll(where: {unwantedChars.contains($0)})
        guard let newNumber = mapNumber else { return "" }
        return newNumber
    }
    
    
    func searchBy(naturalLanguageQuery: String, region: MKCoordinateRegion, coordinates: CLLocationCoordinate2D, completion: @escaping(_ response: MKLocalSearch.Response?, _ error: NSError?) -> Void) {
        
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
    
    
    func presentSafariVC(with url: URL) {
        let safariVC                       = SFSafariViewController(url: url)
        safariVC.preferredBarTintColor     = .white
        safariVC.preferredControlTintColor = .systemRed
        present(safariVC, animated: true)
    }
    
    
    func animateCollectionViewCell(_ collectionView: UICollectionView, atIndexPath indexPath: IndexPath, presentingVC: UIViewController? = nil) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: .zero, options: .curveEaseInOut) {
            selectedCell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            guard let presentingVC = presentingVC else { return }
            self.navigationController?.pushViewController(presentingVC, animated: true)
        }
        UIView.animate(withDuration: 0.2, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: .zero, options: .curveEaseInOut) {
            selectedCell?.transform = .identity
        }
    }
    
    
    func zoomToFocusOn(selectedAnnotation: MKAnnotation?, mapView: MKMapView) {
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
    
}
