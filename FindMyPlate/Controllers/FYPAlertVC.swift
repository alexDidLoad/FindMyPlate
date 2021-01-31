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
    
    
    //MARK: - Properties
    
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
    
    private func configureUI() {
        
        
    }
    
}
