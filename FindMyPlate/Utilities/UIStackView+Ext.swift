//
//  UIStackView+Ext.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/7/21.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(views: [UIView]) {
        views.forEach({addArrangedSubview($0)})
    }
    
}
