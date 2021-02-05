//
//  FMPDirectionsButton.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/4/21.
//

import UIKit

class FMPDirectionsButton: UIButton {
    
    //MARK: - UIComponents
    
    private let label    = FMPTitleLabel(textAlignment: .center, fontSize: 14)
    private let carImage = UIImageView(image: SFSymbols.car)
    
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
        
        backgroundColor    = .systemBlue
        layer.cornerRadius = 7
        
        label.text      = "Directions"
        label.textColor = .white
        addSubview(label)
        label.centerY(inView: self)
        label.anchor(trailing: self.trailingAnchor,
                     paddingTrailing: 8)
        
        carImage.tintColor = .white
        addSubview(carImage)
        carImage.centerY(inView: self)
        carImage.anchor(leading: self.leadingAnchor,
                        trailing: label.leadingAnchor,
                        paddingLeading: 11,
                        paddingTrailing: 6,
                        height: 14,
                        width: 16)
    }
    
}
