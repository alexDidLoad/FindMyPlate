//
//  FMPHomeVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/29/21.
//

import UIKit
import CoreLocation

class FMPHomeVC: FMPViewController {
    
    //MARK: - Properties
    
    private let dataSource = FMPDataSource(withCuisine: nil)
   
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
        configureCollectionView()
        configureLabels()
    }
    
    //MARK: - Helpers
    
    private func configureCollectionView() {
        collectionView.delegate     = self
        collectionView.dataSource   = dataSource
        collectionView.register(FMPCuisineCell.self, forCellWithReuseIdentifier: FMPCuisineCell.reuseID)
    }
    
    
    private func configureLabels() {
        titleLabel.text = Title.chooseCuisine
        bodyLabel.text  = Body.whatAreYouFeelingToday
    }
    
}

//MARK: - UICollectionViewDelegate & DataSource

extension FMPHomeVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = FMPCategoryVC(selectedCuisine: CuisineType.allCases[indexPath.row])
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

//MARK: - CLLocationManagerDelegate

extension FMPHomeVC: CLLocationManagerDelegate {
    
   private func checkLocationServices() {
        
        LocationManager.shared.delegate         = self
        let enableLocationVC                    = EnableLocationVC()
        enableLocationVC.modalPresentationStyle = .fullScreen
        
        switch LocationManager.shared.authorizationStatus {
        
        case .notDetermined:
            DispatchQueue.main.async {
                self.present(enableLocationVC, animated: true)
            }
        case .denied:
            DispatchQueue.main.async {
                self.present(enableLocationVC, animated: true)
            }
        case .authorizedWhenInUse:
            break
        case .authorizedAlways:
            break
        case .restricted:
            break
        @unknown default:
            break
        }
    }
}

