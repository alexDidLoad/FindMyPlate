//
//  FYPEnableLocationButton.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/30/21.
//

import UIKit

class FYPEnableLocationButton: UIButton {
 
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
        backgroundColor      = .systemBlue
        layer.cornerRadius   = 15
        titleLabel?.font     = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
}
