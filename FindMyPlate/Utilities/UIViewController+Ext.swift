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
        let alertVC = FYPAlertVC(title: title, message: message, manager: manager)
        alertVC.modalTransitionStyle     = .crossDissolve
        alertVC.modalPresentationStyle   = .overFullScreen
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true)
        }
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
        safariVC.preferredBarTintColor     = .systemBackground
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
}
