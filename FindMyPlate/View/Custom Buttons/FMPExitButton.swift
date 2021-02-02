//
//  FMPExitButton.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/1/21.
//

import UIKit

protocol FMPExitButtonDelegate: AnyObject {
    func didPressExit()
}

class FMPExitButton: UIButton {
    
    //MARK: - Properties
    
    weak var delegate: FMPExitButtonDelegate?
    
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
        imageView?.setDimensions(height: 40, width: 40)
        setImage(SFSymbols.xmark, for: .normal)
       
        imageView?.frame        = self.bounds
        imageView?.contentMode  = .scaleAspectFit
        layer.cornerRadius      = 20
        layer.masksToBounds     = true
        tintColor               = UIColor.lightGray.withAlphaComponent(0.5)
        
        addTarget(self, action: #selector(handleExitPressed), for: .touchUpInside)
    }
    
    //MARK: - Selectors
    
    @objc private func handleExitPressed() {
        delegate?.didPressExit()
    }
    
}
