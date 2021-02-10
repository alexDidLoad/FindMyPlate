//
//  FMPAlertContainerView.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

class FMPAlertContainerView: UIView {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureView() {
        backgroundColor         = UIColor.white.withAlphaComponent(0.8)
        layer.cornerRadius      = 16
        layer.borderWidth       = 2
        layer.borderColor       = UIColor.black.cgColor
    }
}
