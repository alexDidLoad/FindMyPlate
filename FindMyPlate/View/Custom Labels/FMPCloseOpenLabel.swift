//
//  FMPCloseOpenLabel.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/4/21.
//

import UIKit

class FMPCloseOpenLabel: UILabel {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureLabel() {
        textAlignment       = .center
        font                = UIFont.systemFont(ofSize: 12, weight: .regular)
        layer.cornerRadius  = 6
        layer.masksToBounds = true
    }
}
