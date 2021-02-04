//
//  FMPMapResultCell.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/3/21.
//

import UIKit
import MapKit
import CoreData

protocol FMPMapCellDelegate: AnyObject {
    func getDirections(forMapItem mapItem: MKMapItem)
}


class FMPMapResultCell: UITableViewCell {
    
    //MARK: - UIComponents
    
    private lazy var goButton: UIButton = {
        let button                  = UIButton(type: .system)
        button.alpha                = 1
        button.tintColor            = .white
        button.backgroundColor      = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        button.layer.cornerRadius   = 5
        button.setDimensions(height: 50, width: 50)
        button.setImage(UIImage(systemName: "car.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleGo), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button       = UIButton(type: .system)
        button.tintColor = UIColor.lightGray.withAlphaComponent(0.6)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.imageView?.fillView(button)
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return button
    }()
    
    private let openOrClosedLabel = FMPTitleLabel(textAlignment: .center, fontSize: 12, textColor: .systemGreen)
    private let priceLabel        = FMPTitleLabel(textAlignment: .center, fontSize: 16)
    private let restaurantLabel   = FMPTitleLabel(textAlignment: .left, fontSize: 18)
    
    //MARK: - Properties
    
    static let reuseID = "FMPMapResultCell"
    
    weak var delegate: FMPMapCellDelegate?
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureCell() {
        selectionStyle = .none
        
        contentView.addSubview(goButton)
        goButton.centerY(inView: self)
        goButton.anchor(trailing: trailingAnchor,
                        paddingTrailing: 16)
        
        contentView.addSubview(favoriteButton)
        favoriteButton.centerY(inView: self)
        favoriteButton.anchor(trailing: goButton.leadingAnchor,
                              paddingTrailing: 16,
                              height: 25,
                              width: 35)
        
        addSubview(priceLabel)
        priceLabel.centerY(inView: self)
        priceLabel.anchor(trailing: favoriteButton.leadingAnchor,
                          paddingTrailing: 6,
                          width: 45)
        
        addSubview(openOrClosedLabel)
        openOrClosedLabel.centerY(inView: self)
        openOrClosedLabel.anchor(trailing: priceLabel.leadingAnchor,
                                 paddingTrailing: 16,
                                 height: 30)
        
        addSubview(restaurantLabel)
        restaurantLabel.centerY(inView: self)
        restaurantLabel.anchor(leading: leadingAnchor,
                               trailing: openOrClosedLabel.leadingAnchor,
                               paddingLeading: 16,
                               paddingTrailing: 8)
        
        openOrClosedLabel.text = "Open"
        priceLabel.text = "$$$$"
        restaurantLabel.text = "A Random Restaurant with a long ass name"
    }
    
    //MARK: - Selectors
    
    @objc private func handleGo() {
        print("DEBUG: Handle go here...")
    }
    
    
    @objc private func handleFavorite() {
        print("DEBUG: Handle favorite here...")
    }
    
}
