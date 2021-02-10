//
//  FMPWebsiteButton.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/5/21.
//

import UIKit

class FMPWebsiteButton: UIButton {
    
    //MARK: - UIComponents
    
    private let label      = FMPTitleLabel(textAlignment: .left, fontSize: 14)
    private let globeImage = UIImageView(image: SFSymbols.globe)
    
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
        
        backgroundColor    = .white
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.systemBlue.cgColor
        layer.cornerRadius = 7
        
        label.text      = "Website"
        label.textColor = .systemBlue
        addSubview(label)
        label.centerY(inView: self)
        label.anchor(trailing: trailingAnchor,
                     paddingTrailing: 8)
        
        globeImage.tintColor = .systemBlue
        addSubview(globeImage)
        globeImage.centerY(inView: self)
        globeImage.anchor(leading: self.leadingAnchor,
                        trailing: label.leadingAnchor,
                        paddingLeading: 11,
                        paddingTrailing: 6,
                        height: 18,
                        width: 18)
    }
}
