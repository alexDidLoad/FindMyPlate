//
//  FMPAlertVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit
import CoreLocation

class FMPAlertVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let actionButton: UIButton = {
        let button                  = UIButton(type: .system)
        button.backgroundColor      = .systemRed
        button.layer.cornerRadius   = 12
        button.titleLabel?.font     = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let containerView = FMPAlertContainerView()
    private let titleLabel = FMPTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = FMPBodyLabel(textAlignment: .center)
    
    //MARK: - Properties
    
    let padding: CGFloat = 20
    
    private var alertTitle: String?
    private var message: String?
    
    //MARK: - Init
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle     = title
        self.message        = message
    }
    
    
    convenience init(title: String, message: String, manager: CLLocationManager?) {
        self.init(title: title, message: message)
        
        if let manager = manager {
            checkAuthStatus(manager: manager)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func checkAuthStatus(manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            actionButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        } else {
            actionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        }
    }
    
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.centerInView(view: view)
        containerView.setDimensions(height: 200, width: 290)
    }
    
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong"
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
        messageLabel.text          = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        containerView.addSubview(messageLabel)
        messageLabel.anchor(top: titleLabel.bottomAnchor,
                            leading: containerView.leadingAnchor,
                            bottom: actionButton.topAnchor,
                            trailing: containerView.trailingAnchor,
                            paddingTop: 8,
                            paddingLeading: padding,
                            paddingTrailing: padding)
    }
    
    private func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.anchor(leading: containerView.leadingAnchor,
                            bottom: containerView.bottomAnchor,
                            trailing: containerView.trailingAnchor,
                            paddingLeading: padding,
                            paddingBottom: padding,
                            paddingTrailing: padding,
                            height: 44)
    }
    
    
    private func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    //MARK: - Selectors
    
    @objc private func openSettings() {
        let url = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        dismiss(animated: true)
    }
    
    
    @objc private func dismissAlert() {
        dismiss(animated: true)
    }
    
}
