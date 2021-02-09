//
//  FMPFavoriteAlertVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/8/21.
//

import UIKit

class FMPFavoriteAlertVC: UIViewController {
    
    //MARK: - Properties
    
    private let confirmButton: UIButton = {
        let button                  = UIButton(type: .system)
        button.backgroundColor      = .systemRed
        button.layer.cornerRadius   = 6
        button.titleLabel?.font     = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button                  = UIButton(type: .system)
        button.backgroundColor      = .systemBackground
        button.layer.borderWidth    = 2
        button.layer.borderColor    = UIColor.systemRed.cgColor
        button.layer.cornerRadius   = 6
        button.titleLabel?.font     = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    private let containerView = FMPAlertContainerView()
    private let titleLabel    = FMPTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel  = FMPBodyLabel(textAlignment: .center)
    
    //MARK: - Properties
    
    private var alertTitle: String!
    private var message: String!
    
    private var restaurant: Restaurant!
    private var button: FMPFavoriteButton!
    
    let padding: CGFloat = 20
    
    //MARK: - Init
    
    init(title: String, message: String, forRestaurant restaurant: Restaurant, button: FMPFavoriteButton) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle     = title
        self.message        = message
        self.restaurant     = restaurant
        self.button         = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.centerInView(view: view)
        containerView.setDimensions(height: 200, width: 290)
    }
    
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: containerView.topAnchor,
                          leading: containerView.leadingAnchor,
                          trailing: containerView.trailingAnchor,
                          paddingTop: padding,
                          paddingLeading: padding,
                          paddingTrailing: padding,
                          height: 28
        )
    }
    
    
    private func configureMessageLabel() {
        messageLabel.text          = message
        messageLabel.numberOfLines = 4
        
        containerView.addSubview(messageLabel)
        messageLabel.anchor(top: titleLabel.bottomAnchor,
                            leading: containerView.leadingAnchor,
                            trailing: containerView.trailingAnchor,
                            paddingTop: 28,
                            paddingLeading: padding,
                            paddingTrailing: padding)
    }
    
    
    private func configureButtons() {
        let buttonPadding: CGFloat = 12
        
        let hStack          = UIStackView()
        hStack.axis         = .horizontal
        hStack.alignment    = .center
        hStack.distribution = .fillEqually
        hStack.spacing      = 8
        hStack.addArrangedSubviews(views: [confirmButton, cancelButton])
        containerView.addSubview(hStack)
        
        hStack.anchor(leading: containerView.leadingAnchor,
                      bottom: containerView.bottomAnchor,
                      trailing: containerView.trailingAnchor,
                      paddingLeading: buttonPadding,
                      paddingBottom: buttonPadding,
                      paddingTrailing: buttonPadding)
    }
    
    
    private func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureButtons()
        configureMessageLabel()
    }
    
    //MARK: - Selectors
    
    @objc private func handleConfirm() {
        let favorite = Favorite(name: restaurant.name, rating: restaurant.rating, reviewCount: restaurant.reviewCount, address: restaurant.address, url: restaurant.url, imageUrl: restaurant.imageUrl, phone: restaurant.phone)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self  = self else { return }
            guard let error = error else { self.button.tintColor = .systemRed; return }
            
            self.presentFMPAlertVC(withTitle: "Something went wrong...", message: error.rawValue)
            self.button.tintColor = UIColor.systemGray.withAlphaComponent(0.2)
        }
        dismiss(animated: true)
    }
    
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
}
