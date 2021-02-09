//
//  PersistenceManager.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/7/21.
//

import UIKit

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    //MARK: - Properties
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites" }
    
    //MARK: - Helpers
    
    static func updateWith(favorite: Favorite, actionType: PersistenceActionType, completion: @escaping(FMPError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.name == favorite.name}
                }
                
                completion(save(favorites: favorites))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completion: @escaping(Result<[Favorite], FMPError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder   = JSONDecoder()
            let favorites = try decoder.decode([Favorite].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    
    static func save(favorites: [Favorite]) -> FMPError? {
        do {
            let encoder          = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
