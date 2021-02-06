//
//  FMPMapResultCell.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/3/21.
//

import UIKit
import MapKit
import CoreData
import Cosmos

protocol FMPMapCellDelegate: AnyObject {
    func getDirections(forMapItem mapItem: MKMapItem)
}


class FMPMapResultCell: UITableViewCell {
    
    //MARK: - UIComponents
    
    lazy var directionsButton: FMPDirectionsButton = {
        let button = FMPDirectionsButton()
        button.alpha = 0 
        button.addTarget(self, action: #selector(handleDirections), for: .touchUpInside)
        return button
    }()
    
    lazy var websiteButton: FMPDirectionsButton = {
        
    }
    
    private lazy var favoriteButton: FMPFavoriteButton = {
        let button = FMPFavoriteButton()
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return button
    }()
    
    private let starRatingView: CosmosView = {
        let star = CosmosView()
        star.settings.totalStars       = 5
        star.settings.starMargin       = 1
        star.settings.fillMode         = .half
        star.settings.emptyColor       = UIColor.systemGray.withAlphaComponent(5)
        star.settings.emptyBorderColor = UIColor.systemGray.withAlphaComponent(5)
        star.settings.updateOnTouch    = false
        return star
    }()
    
    private let openOrClosedLabel = FMPCloseOpenLabel()
    private let reviewCountLabel  = FMPTitleLabel(textAlignment: .left, fontSize: 12, textColor: .systemGray)
    private let priceLabel        = FMPTitleLabel(textAlignment: .center, fontSize: 14)
    private let restaurantLabel   = FMPTitleLabel(textAlignment: .left, fontSize: 16)
    
    //MARK: - Properties
    
    static let reuseID = "FMPMapResultCell"
    
    private var restaurant: Restaurant!
    
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
        self.restaurant       = restaurant
        priceLabel.text       = restaurant.price ?? Body.notAvailable
        restaurantLabel.text  = restaurant.name ?? Body.notAvailable
        reviewCountLabel.text = "\(restaurant.review_count ?? 0) Reviews"
        starRatingView.rating = Double(restaurant.rating!)
        
        if restaurant.is_closed == true {
            openOrClosedLabel.text            = "Closed"
            openOrClosedLabel.textColor       = .systemRed
            openOrClosedLabel.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
        } else {
            openOrClosedLabel.text            = "Open"
            openOrClosedLabel.textColor       = .systemGreen
            openOrClosedLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        }
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
                                 paddingLeading: padding,
                                 width: 40)
        
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
                          paddingTop: 6,
                          paddingLeading: padding)
        
        addSubview(starRatingView)
        starRatingView.anchor(top: priceLabel.bottomAnchor,
                              leading: leadingAnchor,
                              paddingTop: 8,
                              paddingLeading: padding)
        
        addSubview(reviewCountLabel)
        reviewCountLabel.centerY(inView: starRatingView, constant: 2)
        reviewCountLabel.anchor(leading: starRatingView.trailingAnchor,
                                paddingLeading: 3)
    }
    
    //MARK: - Selectors
    
    @objc private func handleDirections() {
        guard let latitude  = restaurant.latitude else { return }
        guard let longitude = restaurant.longitude else { return }
        let coordinates     = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let placemark       = MKPlacemark(coordinate: coordinates)
        let mapItem         = MKMapItem(placemark: placemark)
        mapItem.name        = restaurant.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
//        delegate?.getDirections(forMapItem: mapItem)
    }
    
    
    @objc private func handleFavorite() {
        print("DEBUG: Handle favorite here...")
    }
    
}
