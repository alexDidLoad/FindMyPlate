//
//  FMPCategoryVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

class FMPCategoryVC: FMPViewController {
    
    //MARK: - Properties
    
    private var cuisine: CuisineType!
    private var dataSource: FMPDataSource!
    
    //MARK: - Init
    
    init(selectedCuisine: CuisineType) {
        super.init(nibName: nil, bundle: nil)
        
        cuisine = selectedCuisine
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataSource(with: cuisine)
        configureCollectionView()
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    private func setDataSource(with cuisine: CuisineType) {
        dataSource = FMPDataSource(withCuisine: cuisine)
    }
    
    
    private func configureCollectionView() {
        collectionView.delegate     = self
        collectionView.dataSource   = dataSource
        collectionView.register(FMPCuisineCell.self, forCellWithReuseIdentifier: FMPCuisineCell.reuseID)
    }
    
    
    private func configureLabels() {
        switch cuisine {
        case .american:
            titleLabel.text = Title.american
        case .french:
            titleLabel.text = Title.french
        case .chinese:
            titleLabel.text = Title.chinese
        case .italian:
            titleLabel.text = Title.italian
        case .japanese:
            titleLabel.text = Title.japanese
        case .korean:
            titleLabel.text = Title.korean
        case .mexican:
            titleLabel.text = Title.mexican
        case .thai:
            titleLabel.text = Title.thai
        default:
            break
        }
        bodyLabel.text = Body.whichCategory
    }
    
    
    private func configureUI() {
        title = Title.fmp
        configureLabels()
    }
    
}


//MARK: - UICollectionViewDelegate & DataSource

extension FMPCategoryVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FMPCuisineCell
        
        guard let selectedFood        = cell.cuisineLabel.text else { return }
        let destVC                    = FMPMapVC(selectedFood: selectedFood)
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }
    
}
