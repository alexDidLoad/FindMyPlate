//
//  FMPDataSource.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

enum CuisineType: CaseIterable {
    case american, french, italian, mexican, japanese, chinese, thai, korean
}



class FMPDataSource: NSObject, UICollectionViewDataSource {
    
    //MARK: - Properties
    
    private var cuisineType: CuisineType!
    private var cuisineImage: UIImage!
    private var cuisineText: String!
    
    //MARK: - Init
    
    init(withCuisine cuisine: CuisineType?) {
        super.init()
       
        cuisineType = cuisine
    }
    
    //MARK: - Helpers
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cuisineType {
        case .american:
            return Cuisine.americanFood.count
            
        case .french:
            return Cuisine.frenchFood.count
        
        case .italian:
            return Cuisine.italianFood.count
        
        case .mexican:
            return Cuisine.mexicanFood.count
        
        case .japanese:
            return Cuisine.japaneseFood.count
        
        case .chinese:
            return Cuisine.chineseFood.count
        
        case .thai:
            return Cuisine.thaiFood.count
        
        case .korean:
            return Cuisine.koreanFood.count
        
        default:
            return CuisineType.allCases.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cuisineType {
        case .american:
            cuisineImage    = setImage(to: Cuisine.americanFood, atIndexPath: indexPath)
            cuisineText     = Cuisine.americanFood[indexPath.row].capitalized
            
        case .french:
            cuisineImage    = setImage(to: Cuisine.frenchFood, atIndexPath: indexPath)
            cuisineText     = Cuisine.frenchFood[indexPath.row].capitalized
            
        case .italian:
            cuisineImage    = setImage(to: Cuisine.italianFood, atIndexPath: indexPath)
            cuisineText     = Cuisine.italianFood[indexPath.row].capitalized
            
        case .mexican:
            cuisineImage    = setImage(to: Cuisine.mexicanFood, atIndexPath: indexPath)
            cuisineText     = Cuisine.mexicanFood[indexPath.row].capitalized
            
        case .japanese:
            cuisineImage    = setImage(to: Cuisine.japaneseFood, atIndexPath: indexPath)
            cuisineText     = Cuisine.japaneseFood[indexPath.row].capitalized
            
        case .chinese:
            cuisineImage    = setImage(to: Cuisine.chineseFood, atIndexPath: indexPath)
            cuisineText     = Cuisine.chineseFood[indexPath.row].capitalized
            
        case .thai:
            cuisineImage    = setImage(to: Cuisine.thaiFood, atIndexPath: indexPath)
            cuisineText     = Cuisine.thaiFood[indexPath.row].capitalized

        case .korean:
            cuisineImage    = setImage(to: Cuisine.koreanFood, atIndexPath: indexPath)
            cuisineText     = Cuisine.koreanFood[indexPath.row].capitalized
            
        default:
            cuisineImage    = UIImage(named: Cuisine.cuisines[indexPath.row])
            cuisineText     = Cuisine.cuisines[indexPath.row].capitalized
        }
        
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: FMPCuisineCell.reuseID, for: indexPath) as! FMPCuisineCell
        cell.set(withImage: cuisineImage!, text: cuisineText)
        return cell
    }
    
    
    private func setImage(to cuisine: [String], atIndexPath indexPath: IndexPath) -> UIImage {
        guard let image = UIImage(named: cuisine[indexPath.row]) else { return SFSymbols.questionmark! }
        return image
    }
    
    
}
