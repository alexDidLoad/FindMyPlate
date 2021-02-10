//
//  UITableViewCell+Ext.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/9/21.
//

import UIKit

extension UITableViewCell {
    
    func animateButtons(buttons: [UIButton]) {
        
        for button in buttons {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: .zero, options: .curveEaseInOut) {
                button.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                button.alpha     = 1
            } completion: { (_) in
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: .zero, options: .curveEaseInOut) {
                    button.transform = .identity
                }
            }
        }
        
    }
    
}
