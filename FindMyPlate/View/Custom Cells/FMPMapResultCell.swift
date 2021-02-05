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
    
    private lazy var directionsButton: FMPDirectionsButton = {
        let button = FMPDirectionsButton()
        button.addTarget(self, action: #selector(handleDirections), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: FMPFavoriteButton = {
        let button = FMPFavoriteButton()
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return button
    }()
    
    private let openOrClosedLabel = FMPCloseOpenLabel()
    private let priceLabel        = FMPTitleLabel(textAlignment: .center, fontSize: 14, textColor: .systemGreen)
    private let restaurantLabel   = FMPTitleLabel(textAlignment: .left, fontSize: 16)
    
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
    
    func set(restaurant: Restaurant) {
        priceLabel.text = restaurant.price ?? "N/A"
        restaurantLabel.text = restaurant.name ?? "N/A"
    }
    
    private func configureCell() {
        selectionStyle       = .none
        let padding: CGFloat = 16
        
        contentView.addSubview(directionsButton)
        directionsButton.anchor(bottom: bottomAnchor,
                                trailing: trailingAnchor,
                                paddingBottom: padding,
                                paddingTrailing: padding,
                                height: 42,
                                width: 110)
        
        contentView.addSubview(favoriteButton)
        favoriteButton.anchor(top: topAnchor,
                              trailing: trailingAnchor,
                              paddingTop: padding,
                              paddingTrailing: padding,
                              height: 24,
                              width: 26)
        
        addSubview(openOrClosedLabel)
        openOrClosedLabel.anchor(top: topAnchor,
                                 leading: leadingAnchor,
                                 paddingTop: padding,
                                 paddingLeading: padding)
        
        addSubview(restaurantLabel)
        restaurantLabel.anchor(top: openOrClosedLabel.bottomAnchor,
                               leading: leadingAnchor,
                               trailing: favoriteButton.trailingAnchor,
                               paddingTop: 6,
                               paddingLeading: padding,
                               height: 38)
        
        addSubview(priceLabel)
        priceLabel.anchor(top: restaurantLabel.bottomAnchor,
                          leading: leadingAnchor,
                          paddingTop: 8,
                          paddingLeading: padding)
        
        
        openOrClosedLabel.text = "Closed"
        priceLabel.text = "$$$$"
        restaurantLabel.text = "A Random Restaurant with a long ass name"
    }
    
    //MARK: - Selectors
    
    @objc private func handleDirections() {
        print("DEBUG: Handle go here...")
    }
    
    
    @objc private func handleFavorite() {
        print("DEBUG: Handle favorite here...")
    }
    
}
