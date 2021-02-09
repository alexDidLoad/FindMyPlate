//
//  FMPFavoriteCellContainerView.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/6/21.
//

import UIKit

class FMPFavoriteCellContainerView: UIView {
    
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
        
        layer.cornerRadius = 12
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.black.withAlphaComponent(0.2).cgColor
        backgroundColor    = .white
    }
    
}
