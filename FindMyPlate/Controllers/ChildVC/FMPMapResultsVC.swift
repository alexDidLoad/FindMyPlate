//
//  FMPMapResultsVC.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/1/21.
//

import UIKit
import MapKit

protocol FMPMapResultsVCDelegate: AnyObject {
    func addAnnotations(forRestaurants restaurants: [Restaurant])
    func didSelectAnnotation(withMapItem mapItem: MKMapItem)
}

class FMPMapResultsVC: UIViewController {
    
    //MARK: - UIComponents
    
    private var containerView = UIView()
    
    //MARK: - Properties
    
    enum Section { case main }
    
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Restaurant>
    typealias SnapShot           = NSDiffableDataSourceSnapshot<Section, Restaurant>
    
    weak var delegate: FMPMapResultsVCDelegate?
    
    private var selectedFood: String!
    var restaurants = [Restaurant]()
    
    var tableView: UITableView!
    private var dataSource: DiffableDataSource!
    
    //MARK: - Init
    
    init(selectedFood: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.selectedFood = selectedFood
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureDataSource()
        getRestaurants(withSearchQuery: selectedFood)
    }
    
    //MARK: - Helper
    
    private func showLoadingView() {
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        view.addSubview(containerView)
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator   = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .darkGray
        containerView.addSubview(activityIndicator)
        activityIndicator.centerInView(view: containerView)
        activityIndicator.startAnimating()
    }
    
    
    private func dismissLoadingview() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
        }
    }
    
    
    private func fetchRestaurants(with numbers: [String]) {
        showLoadingView()
        numbers.forEach({ number in
            NetworkManager.shared.getRestaurants(fromPhoneNumber: number) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingview()
                
                switch result {
                case .success(let restaurants):
                    self.updateUI(with: restaurants)
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.presentFMPAlertVC(withTitle: "Sorry!", message: error.rawValue)
                    }
                    break
                }
            }
        })
    }
    
    
    private func getRestaurants(withSearchQuery query: String) {
        guard let userLocation = LocationManager.shared.location?.coordinate else { return }
        let region             = MKCoordinateRegion(center: userLocation, latitudinalMeters: 100, longitudinalMeters: 100)
        var phoneNumbers       = [String]()
        
        searchBy(naturalLanguageQuery: query, region: region, coordinates: userLocation) { [weak self] (response, error) in
            guard let self     = self else { return }
            guard let response = response else { return }
            
            response.mapItems.forEach({ mapItem in phoneNumbers.append(self.getMapItemPhoneNumber(mapItem)) })
            self.fetchRestaurants(with: phoneNumbers)
        }
    }
    
    
    private func updateUI(with restaurants: [Restaurant]) {
        
        self.restaurants.append(contentsOf: restaurants)
        self.updateData(on: self.restaurants)
        self.delegate?.addAnnotations(forRestaurants: restaurants)
    }
    
    
    private func updateData(on restaurants: [Restaurant]) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(restaurants)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: false) }
    }
    
    
    private func configureDataSource() {
        dataSource = DiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, restaurant) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: FMPMapResultCell.reuseID, for: indexPath) as! FMPMapResultCell
            cell.delegate = self
            cell.set(restaurant: restaurant)
            return cell
        })
    }
    
    
    private func configureTableView() {
        tableView                                = UITableView()
        tableView.backgroundColor                = UIColor.white.withAlphaComponent(0.8)
        tableView.tableFooterView                = UIView(frame: .zero)
        tableView.rowHeight                      = 142
        tableView.delegate                       = self
        tableView.isScrollEnabled                = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(FMPMapResultCell.self, forCellReuseIdentifier: FMPMapResultCell.reuseID)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
    }
    
}

//MARK: - UITableViewDelegate

extension FMPMapResultsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMapItem    = MKMapItem()
        let selectedRestaurant = restaurants[indexPath.row]
        selectedMapItem.name   = selectedRestaurant.name
        
        delegate?.didSelectAnnotation(withMapItem: selectedMapItem)
        
        restaurants.remove(at: indexPath.row)
        restaurants.insert(selectedRestaurant, at: 0)
        restaurants.removeSubrange(1..<restaurants.count)
        updateData(on: restaurants)
        
        let newIndexPath = IndexPath(row: 0, section: 0)
        guard let cell = tableView.cellForRow(at: newIndexPath) as? FMPMapResultCell else { return }
        cell.selectedIndex = indexPath.row
        if cell.restaurantImageView.alpha == 1 { DispatchQueue.main.async { cell.animateButtonsIn() } } else { return }
    }
}

//MARK: - FMPMapResultCellDelegate

extension FMPMapResultsVC: FMPMapResultCellDelegate {
    
    func didFavorite(restaurant: Restaurant, button: FMPFavoriteButton) {
        presentFMPFavoriteVC(withTitle: restaurant.name!, message: "Do you want to favorite this restaurant?", restaurant: restaurant, button: button)
    }
    
    
    func goToWebsite(with url: URL?) {
        if let url = url {
            presentSafariVC(with: url)
        } else {
            presentFMPAlertVC(withTitle: "Invalid URL", message: ErrorMessage.invalidURL)
        }
    }
    
}
