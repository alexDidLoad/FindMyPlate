//
//  FMPIndicatorView.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/1/21.
//

import UIKit

class FMPIndicatorView: UIView {
    
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
        backgroundColor     = .lightGray
        alpha               = 0.8
        layer.cornerRadius  = 5
    }
    
}
