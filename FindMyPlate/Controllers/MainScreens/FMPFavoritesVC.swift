//
//  FMPFavoritesVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/30/21.
//

import UIKit

class FMPFavoritesVC: UIViewController {
    
    //MARK: - Properties
    
    private let tableView =  UITableView()
    private var favorites =  [Favorite]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }
    
    //MARK: - Helpers
    
    private func updateUI(with favorites: [Favorite]) {
        if favorites.isEmpty {
            presentFMPAlertVC(withTitle: "No Favorites 😭", message: "You currently don't have any favorites")
        } else {
            self.favorites = favorites
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
  
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                self.presentFMPAlertVC(withTitle: "Something went wrong...", message: error.rawValue)
            }
        }
    }
    
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame             = view.bounds
        tableView.tableFooterView   = UIView(frame: .zero)
        tableView.backgroundColor   = .white
        tableView.rowHeight         = 185
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.register(FMPFavoriteCell.self, forCellReuseIdentifier: FMPFavoriteCell.reuseID)
    }
    
}

//MARK: - UITableViewDelegate and Datasource

extension FMPFavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: FMPFavoriteCell.reuseID, for: indexPath) as! FMPFavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = favorites[indexPath.row].url else { return }
        let url = URL(string: urlString)
        presentSafariVC(with: url!)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentFMPAlertVC(withTitle: "Unable to remove", message: error.rawValue)
        }
    }
    
}

