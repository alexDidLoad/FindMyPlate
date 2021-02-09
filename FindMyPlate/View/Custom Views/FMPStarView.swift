//
//  FMPStarView.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/5/21.
//

import UIKit
import Cosmos

class FMPStarView: CosmosView {
    
    //MARK: - Init
    
    override init(frame: CGRect, settings: CosmosSettings) {
        super.init(frame: frame, settings: settings)
        
        configureView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureView() {
        settings.totalStars       = 5
        settings.starMargin       = 1
        settings.fillMode         = .half
        settings.emptyColor       = UIColor.systemGray.withAlphaComponent(5)
        settings.emptyBorderColor = UIColor.systemGray.withAlphaComponent(5)
        settings.updateOnTouch    = false
    }
    
}
