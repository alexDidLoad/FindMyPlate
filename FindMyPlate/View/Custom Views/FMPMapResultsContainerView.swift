//
//  FMPMapResultsContainerView.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/1/21.
//

import UIKit

class FMPMapResultsContainerView: UIView {
    
    //MARK: - UIComponents
    
    private let indicator = FMPIndicatorView()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        backgroundColor     = .white
        layer.cornerRadius  = 14
        layer.shadowRadius  = 10
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0, height: -5)
        layer.shadowOpacity = 0.3
        
        addSubview(indicator)
        indicator.centerX(inView: self)
        indicator.anchor(top: topAnchor,
                         paddingTop: 8,
                         height: 8,
                         width: 80)
    }
    
}
