//
//  FMPEnableLocationButton.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/30/21.
//

import UIKit

class FMPEnableLocationButton: UIButton {
 
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper
    
    private func configureButton() {
        setTitle("Enable Locations", for: .normal)
        titleLabel?.font         = UIFont.systemFont(ofSize: 18, weight: .semibold)
        backgroundColor          = .systemBlue
        layer.cornerRadius       = 15
        layer.shadowColor        = UIColor.black.cgColor
        layer.shadowOffset       = CGSize(width: 2, height: 2)
        layer.shadowOpacity      = 1
        layer.shadowRadius       = 1
        layer.shouldRasterize    = true
        layer.rasterizationScale = UIScreen.main.scale
        
    }
}

