//
//  FMPBodyLabel.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

class FMPBodyLabel: UILabel {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat? = nil) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
        
        guard let fontSize = fontSize else { return }
        self.font          = UIFont.systemFont(ofSize: fontSize)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        textColor                           = .black
        font                                = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory   = true
        adjustsFontSizeToFitWidth           = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
    }
    
}
