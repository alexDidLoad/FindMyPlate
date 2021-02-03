//
//  FMPMapResultsVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/1/21.
//

import UIKit

class FMPMapResultsVC: UIViewController {
    
    //MARK: - UIComponents
    
    
    //MARK: - Properties
    
    var tableView: UITableView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helper
    
    private func configureTableView() {
        tableView                                = UITableView()
        tableView.rowHeight                      = 112
        tableView.delegate                       = self
        tableView.dataSource                     = self
        tableView.isScrollEnabled                = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(FMPMapResultCell.self, forCellReuseIdentifier: FMPMapResultCell.reuseID)
        
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
    }
    
    private func configureUI() {
        configureTableView()
    }
    
}

//MARK: - UITableViewDelegate & Datasource

extension FMPMapResultsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FMPMapResultCell.reuseID, for: indexPath) as! FMPMapResultCell
        
        return cell
    }
    
}
