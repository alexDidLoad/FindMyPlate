//
//  FMPItemImageView.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

class FMPItemImageView: UIImageView {
    
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
        let dimensions: CGFloat = 160
        setDimensions(height: dimensions, width: dimensions)
        
        layer.cornerRadius  = dimensions / 2
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.white.cgColor
        clipsToBounds       = true
        contentMode         = .scaleAspectFill
    }
}
