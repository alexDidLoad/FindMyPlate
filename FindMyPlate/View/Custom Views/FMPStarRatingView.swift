//
//  FMPStarRatingView.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/4/21.
//

import UIKit

class FMPStarRatingView: UIView {
    
    //MARK: - UIComponents
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment     = .leading
        stack.axis          = .horizontal
        stack.distribution  = .fillEqually
        stack.spacing       = 2
        return stack
    }()
    
    //MARK: - Properties
    
    enum StarRounding: Int {
        case noStar     = 0
        case oneStar    = 1
        case twoStar    = 2
        case threeStar  = 3
        case fourStar   = 4
        case fiveStar   = 5
    }
    
    private var rating: Float!
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    
    convenience init(rating: Float) {
        self.init(frame: .zero)
        
        self.rating = rating
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    
    private func configureView() {
        
        addSubview(hStack)
        hStack.fillView(self)
        
        
    }
    
}
