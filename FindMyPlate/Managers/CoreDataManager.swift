//
//  CoreDataManager.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/5/21.
//

import UIKit
import CoreData

protocol CoreDataManagerDelegate: AnyObject {
    func errorWithSaving()
    func errorWithFetching()
}

class CoreDataManager {
    
    //MARK: - Properties
    
    static let shared = CoreDataManager()
    let context       = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    weak var delegate: CoreDataManagerDelegate?
    
    //MARK: - Helpers
    
    func saveFavorite(_ restaurant: Restaurant) {
        guard let latitude = restaurant.latitude else { return }
        guard let longitude = restaurant.longitude else { return }
        
        let newFavorite         = Favorite(context: self.context)
        newFavorite.name        = restaurant.name
        newFavorite.rating      = restaurant.rating ?? 0.0
        newFavorite.address     = restaurant.address
        newFavorite.phoneNumber = restaurant.phone
        newFavorite.reviewCount = Int64(restaurant.review_count!)
        newFavorite.latitude    = latitude
        newFavorite.longitude   = longitude
        
        convertImageFrom(urlString: restaurant.image_url!) { data in
            newFavorite.image = data
        }
        
        do {
            try self.context.save()
        } catch {
            delegate?.errorWithSaving()
        }
    }
    
    
    func deleteFavorite(_ favorite: Favorite) {
        self.context.delete(favorite)
        
        do {
            try self.context.save()
        } catch {
            delegate?.errorWithSaving()
        }
    }
    
    
    func fetchFavorite() -> [Favorite]? {
        var favorites: [Favorite]?
        do {
            favorites = try context.fetch(Favorite.fetchRequest())
            return favorites
        } catch {
            delegate?.errorWithFetching()
        }
        return favorites
    }
    
    
    private func convertImageFrom(urlString: String, completion: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                      let data = data else {
                    completion(nil)
                    return
                }
                completion(data)
            }
        }
        
        task.resume()
    }
    
}
