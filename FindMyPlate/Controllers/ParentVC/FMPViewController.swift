//
//  FMPViewController.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

class FMPViewController: UIViewController {
    
    //MARK: - UIComponents
    
    let containerView: UIView = {
        let cv                      = UIView()
        cv.layer.cornerRadius       = 45
        cv.layer.shadowColor        = UIColor.black.cgColor
        cv.layer.shadowOffset       = .zero
        cv.layer.shadowOpacity      = 0.25
        cv.layer.shadowRadius       = 10
        cv.layer.shouldRasterize    = true
        cv.layer.rasterizationScale = UIScreen.main.scale
        cv.layer.zPosition          = 1
        return cv
    }()
    
    let titleLabel    = FMPTitleLabel(textAlignment: .left, fontSize: 24)
    let bodyLabel     = FMPBodyLabel(textAlignment: .left)
    
    //MARK: - Properties
    
    var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    
    
    
    private func configureCollectionView() {
        collectionView                      = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        collectionView.backgroundColor      = .systemBackground
        view.addSubview(collectionView)
        collectionView.anchor(top: containerView.bottomAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor,
                              paddingTop: -5)
    }
    
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground

        containerView.anchor(top: view.topAnchor,
                             leading: view.leadingAnchor,
                             trailing: view.trailingAnchor,
                             paddingTop: 40,
                             height: 145)
        
        containerView.addSubview(titleLabel)
        titleLabel.anchor(leading: containerView.leadingAnchor,
                          bottom: containerView.bottomAnchor,
                          trailing: containerView.trailingAnchor,
                          paddingLeading: 20,
                          paddingBottom: 50,
                          height: 28)
        
        containerView.addSubview(bodyLabel)
        bodyLabel.anchor(top: titleLabel.bottomAnchor,
                         leading: titleLabel.leadingAnchor,
                         trailing: containerView.trailingAnchor,
                         paddingTop: 12,
                         height: 22)
        
        configureCollectionView()
    }
    
}
