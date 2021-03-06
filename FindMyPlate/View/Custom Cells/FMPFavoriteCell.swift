//
//  FMPFavoriteCell.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/6/21.
//

import UIKit

class FMPFavoriteCell: UITableViewCell {
    
    //MARK: - UIComponents
    
    private let restaurantImageView = FMPItemImageView(frame: .zero)
    private let titleLabel          = FMPTitleLabel(textAlignment: .left, fontSize: 16)
    private let starView            = FMPStarView()
    private let reviewCountLabel    = FMPTitleLabel(textAlignment: .left, fontSize: 12, textColor: .systemGray)
    private let addressLabel        = FMPBodyLabel(textAlignment: .left, fontSize: 14)
    private let phoneNumber         = FMPBodyLabel(textAlignment: .left, fontSize: 12)
    
    private let yelpIcon            = UIImageView(image: Icons.yelpIcon)
    private let discloserIndicator  = UIImageView(image: SFSymbols.indicator)
    
    //MARK: - Properties
    
    static let reuseID = "FMPFavoriteCell"
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func set(favorite: Favorite) {
        restaurantImageView.downloadImage(fromURL: favorite.imageUrl!)
        titleLabel.text         = favorite.name
        starView.rating         = Double(favorite.rating ?? 0)
        reviewCountLabel.text   = "\(favorite.reviewCount ?? 0) Reviews"
        addressLabel.text       = favorite.address
        phoneNumber.text        = favorite.phone
    }
    
    
    private func configureCell() {
        backgroundColor      = .clear
        selectionStyle       = .none
        
        let padding: CGFloat = 36
        
        contentView.addSubview(restaurantImageView)
        restaurantImageView.centerY(inView: self)
        restaurantImageView.anchor(leading: leadingAnchor,
                                   paddingLeading: 8)
        
        let stackView           = UIStackView()
        stackView.axis          = .vertical
        stackView.alignment     = .leading
        stackView.distribution  = .equalSpacing
        stackView.addArrangedSubviews(views: [titleLabel, starView, addressLabel, phoneNumber])
        
        contentView.addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         leading: restaurantImageView.trailingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         paddingTop: padding,
                         paddingLeading: 8,
                         paddingBottom: padding,
                         paddingTrailing: padding)
        
        stackView.addSubview(reviewCountLabel)
        reviewCountLabel.centerY(inView: starView)
        reviewCountLabel.anchor(leading: starView.trailingAnchor,
                                paddingLeading: 4)
        
        addSubview(discloserIndicator)
        discloserIndicator.tintColor = .systemRed
        discloserIndicator.anchor(bottom: bottomAnchor,
                                  trailing: trailingAnchor,
                                  paddingBottom: padding / 4,
                                  paddingTrailing: padding / 4)
        
        addSubview(yelpIcon)
        yelpIcon.setDimensions(height: 20, width: 20)
        yelpIcon.centerY(inView: discloserIndicator, constant: -2)
        yelpIcon.anchor(trailing: discloserIndicator.leadingAnchor,
                        paddingTrailing: 2)
    }
}
