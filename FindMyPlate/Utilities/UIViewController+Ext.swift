//
//  UIViewController+Ext.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit
import MapKit
import CoreLocation

extension UIViewController {
    
    func presentFYPAlertVC(with title: String, message: String, manager: CLLocationManager? = nil) {
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
    
}
