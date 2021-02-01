//
//  FMPViewController.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/31/21.
//

import UIKit

class FMPViewController: UIViewController {
    
    //MARK: - UIComponents
    
    let containerView = UIView()
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
                              trailing: view.trailingAnchor)
    }
    
    
    private func configureUI() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground

        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             leading: view.leadingAnchor,
                             trailing: view.trailingAnchor,
                             height: 100)
        
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: containerView.topAnchor,
                          leading: containerView.leadingAnchor,
                          trailing: containerView.trailingAnchor,
                          paddingTop: 28,
                          paddingLeading: 20,
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
