//
//  FYPAlertVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

class FYPAlertVC: UIViewController {
    
    //MARK: - UIComponents
    
    private let containerView = FYPAlertContainerView()
    private let titleLabel = FYPTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = FYPBodyLabel(textAlignment: .center)
    private let actionButton: UIButton = {
        let button              = UIButton(type: .system)
        button.backgroundColor  = .systemRed
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    let padding: CGFloat = 20
    
    private var alertTitle: String?
    private var message: String?
    
    //MARK: - Lifecycle
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle     = title
        self.message        = message
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.centerInView(view: view)
        containerView.setDimensions(height: 280, width: 220)
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
        actionButton.setTitle("Ok", for: .normal)
        
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
    
    @objc private func dismissAlert() {
        dismiss(animated: true)
    }
    
}
