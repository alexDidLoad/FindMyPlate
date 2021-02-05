//
//  FMPFavoriteButton.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/4/21.
//

import UIKit

class FMPFavoriteButton: UIButton {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureButton() {
        
        tintColor = UIColor.lightGray.withAlphaComponent(0.6)

        setImage(SFSymbols.heart, for: .normal)
        imageView?.fillView(self)
    }
    
}

