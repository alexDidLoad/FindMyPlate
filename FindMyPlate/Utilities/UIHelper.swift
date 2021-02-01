//
//  UIHelper.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

enum UIHelper {
    
    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
            let width = view.bounds.width
            let padding: CGFloat = 2
            let minimumItemSpacing: CGFloat = 5
            let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
            let itemWidth = availableWidth / 2
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
            return flowLayout
        }
}
