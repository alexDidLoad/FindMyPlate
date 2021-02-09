//
//  FMPRestuarantImageView.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/5/21.
//

import UIKit

class FMPRestaurantImageView: UIImageView {
    
    //MARK: - UIComponents
    
    let placeholderImage = SFSymbols.error
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImage()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.cacheImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
    
    private func configureImage() {
        image               = placeholderImage
        contentMode         = .scaleAspectFill
        layer.cornerRadius  = 6
        layer.masksToBounds = true
    }
    
}
