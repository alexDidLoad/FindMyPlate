//
//  FMPCenterOnUserButton.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/1/21.
//

import UIKit

protocol FMPCenterOnUserButtonDelegate: AnyObject {
    func didPressCenter()
}

class FMPCenterOnUserButton: UIButton {
    
    //MARK: - Properties
    
    weak var delegate: FMPCenterOnUserButtonDelegate?
    
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
        imageView?.setDimensions(height: 30, width: 35)
        setImage(SFSymbols.paperPlane, for: .normal)
        
        backgroundColor     = UIColor.white.withAlphaComponent(0.8)
        tintColor           = .systemRed
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.cornerRadius  = 13
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowRadius  = 1
        layer.shadowOffset  = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.3
        
        addTarget(self, action: #selector(handleCenterPressed), for: .touchUpInside)
    }
    
    //MARK: - Selectors
    
    @objc private func handleCenterPressed() {
        delegate?.didPressCenter()
    }
    
}
