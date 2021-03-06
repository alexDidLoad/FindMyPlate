//
//  FMPMapResultCell.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/3/21.
//

import UIKit
import MapKit

protocol FMPMapResultCellDelegate: AnyObject {
    func goToWebsite(with url: URL?)
    func didFavorite(restaurant: Restaurant, button: FMPFavoriteButton)
}

class FMPMapResultCell: UITableViewCell {
    
    //MARK: - UIComponents
    
    private lazy var directionsButton: FMPDirectionsButton = {
        let button = FMPDirectionsButton()
        button.alpha = 0 
        button.addTarget(self, action: #selector(handleDirections), for: .touchUpInside)
        return button
    }()
    
    private lazy var websiteButton: FMPWebsiteButton = {
        let button = FMPWebsiteButton()
        button.alpha = 0
        button.addTarget(self, action: #selector(handleWebsite), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: FMPFavoriteButton = {
        let button = FMPFavoriteButton()
        button.alpha = 0
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return button
    }()
    
    let restaurantImageView          = FMPRestaurantImageView(frame: .zero)
    private let starRatingView       = FMPStarView()
    private let openOrClosedLabel    = FMPCloseOpenLabel()
    private let reviewCountLabel     = FMPTitleLabel(textAlignment: .left, fontSize: 12, textColor: .systemGray)
    private let priceLabel           = FMPTitleLabel(textAlignment: .center, fontSize: 14)
    private let restaurantLabel      = FMPTitleLabel(textAlignment: .left, fontSize: 16)
    private let edgePadding: CGFloat = 16
    
    //MARK: - Properties
    
    static let reuseID  = "FMPMapResultCell"
    
    private var isFavorite = false
    var selectedIndex: Int!
    
    private var restaurant: Restaurant!
    
    weak var delegate: FMPMapResultCellDelegate?
    
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
        reviewCountLabel.text = "\(restaurant.reviewCount ?? 0) Reviews"
        starRatingView.rating = Double(restaurant.rating!)
        
        restaurantImageView.downloadImage(fromURL: restaurant.imageUrl!)
        
        guard let isClosed = restaurant.isClosed else { return }
        
        if isClosed {
            openOrClosedLabel.text            = "Closed"
            openOrClosedLabel.textColor       = .systemRed
            openOrClosedLabel.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
        } else if !isClosed {
            openOrClosedLabel.text            = "Open"
            openOrClosedLabel.textColor       = .systemGreen
            openOrClosedLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        }
    }
    
    
    func animateButtonsIn() {
        restaurantImageView.alpha   = 0
        directionsButton.transform  = CGAffineTransform(scaleX: 0.25, y: 0.25)
        websiteButton.transform     = CGAffineTransform(scaleX: 0.25, y: 0.25)
        
        animateButtons(buttons: [favoriteButton, directionsButton, websiteButton])
    }
    
    
    private func configureButtons() {
        contentView.addSubview(favoriteButton)
        favoriteButton.anchor(top: topAnchor,
                              trailing: trailingAnchor,
                              paddingTop: edgePadding,
                              paddingTrailing: edgePadding,
                              height: 24,
                              width: 26)
        
        contentView.addSubview(directionsButton)
        directionsButton.anchor(top: favoriteButton.bottomAnchor,
                                trailing: trailingAnchor,
                                paddingTop: 6,
                                paddingTrailing: edgePadding,
                                height: 36,
                                width: 110)
        
        contentView.addSubview(websiteButton)
        websiteButton.anchor(top: directionsButton.bottomAnchor,
                             trailing: trailingAnchor,
                             paddingTop: 5,
                             paddingTrailing: edgePadding,
                             height: 36,
                             width: 110)
    }
    
    
    private func configureCell() {
        selectionStyle  = .none
        backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        configureButtons()
        
        addSubview(restaurantImageView)
        restaurantImageView.anchor(bottom: bottomAnchor,
                                   trailing: trailingAnchor,
                                   paddingBottom: edgePadding,
                                   paddingTrailing: edgePadding,
                                   height: 100,
                                   width: 130)
        
        addSubview(openOrClosedLabel)
        openOrClosedLabel.anchor(top: topAnchor,
                                 leading: leadingAnchor,
                                 paddingTop: edgePadding,
                                 paddingLeading: edgePadding,
                                 width: 45)
        
        addSubview(restaurantLabel)
        restaurantLabel.anchor(top: openOrClosedLabel.bottomAnchor,
                               leading: leadingAnchor,
                               trailing: restaurantImageView.leadingAnchor,
                               paddingTop: 12,
                               paddingLeading: edgePadding,
                               paddingTrailing: 6,
                               height: 20)
        
        addSubview(priceLabel)
        priceLabel.anchor(top: restaurantLabel.bottomAnchor,
                          leading: leadingAnchor,
                          paddingTop: 12,
                          paddingLeading: edgePadding)
        
        addSubview(starRatingView)
        starRatingView.anchor(top: priceLabel.bottomAnchor,
                              leading: leadingAnchor,
                              paddingTop: 12,
                              paddingLeading: edgePadding)
        
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
    }
    
    
    @objc private func handleWebsite() {
        guard let url = URL(string: restaurant.url!) else { return }
        delegate?.goToWebsite(with: url)
    }
    
    
    @objc private func handleFavorite() {
        delegate?.didFavorite(restaurant: restaurant, button: favoriteButton)
    }
}

