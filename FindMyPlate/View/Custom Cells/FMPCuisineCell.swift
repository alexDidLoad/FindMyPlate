//
//  FMPCuisineCell.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

class FMPCuisineCell: UICollectionViewCell {
    
    //MARK: - UIComponents
    
    let cuisineImageView = FMPItemImageView(frame: .zero)
    let cuisineLabel     = FMPTitleLabel(textAlignment: .center, fontSize: 16)
    
    //MARK: - Properties
    
    static let reuseID = "FMPCuisineCell"
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    func set(withImage image: UIImage, text: String) {
        cuisineImageView.image = image
        cuisineLabel.text      = text
    }
    
    
    private func configureUI() {
        
        addSubview(cuisineImageView)
        cuisineImageView.centerX(inView: contentView)
        cuisineImageView.anchor(top: contentView.topAnchor,
                                paddingTop: 8)
        
        addSubview(cuisineLabel)
        cuisineLabel.text = "Test"
        cuisineLabel.anchor(top: cuisineImageView.bottomAnchor,
                            leading: contentView.leadingAnchor,
                            trailing: contentView.trailingAnchor,
                            paddingTop: 15)
    }
    
}
