//
//  NetworkManager.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/3/21.
//

import UIKit

class NetworkManager {
    
    //MARK: - Properties
    
    static let shared   = NetworkManager()
    
    let cache = NSCache<NSString, UIImage>()
    
    private let baseURL = "https://api.yelp.com/"
    private let apiKey  = "tVZXzeGIlJszxne7a8-NA35qptfSQ-ZRqklN8U6oY737KqbcE8PuP4ALQ8Gg6RI9lH1St7dxRdIsXUGI9gcUI90F5H4nXB9-8y1HbbX-Sa1o4gOcw6exl8n_uokcYHYx"
    
    //MARK: - Lifecycle
    
    private init() {}
    
    //MARK: - Helpers
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        task.resume()
    }
    
    
    func getRestaurants(fromPhoneNumber phone: String, completion: @escaping (Result<[Restaurant], FMPError>) -> Void) {
        
        guard let url = URL(string: baseURL + "v3/businesses/search/phone?phone=\(phone)") else { return }
        var request   = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let _ = response else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json             = try JSONSerialization.jsonObject(with: data, options: [])
                guard let response   = json as? NSDictionary else { return }
                guard let businesses = response.value(forKey: "businesses") as? [NSDictionary] else { return }
                var restaurantList   = [Restaurant]()
                
                for business in businesses {
                    var restaurant          = Restaurant()
                    restaurant.name         = business.value(forKey: "name")            as? String
                    restaurant.rating       = business.value(forKey: "rating")          as? Float
                    restaurant.review_count = business.value(forKey: "review_count")    as? Int
                    restaurant.price        = business.value(forKey: "price")           as? String
                    restaurant.is_closed    = business.value(forKey: "is_closed")       as? Bool
                    restaurant.url          = business.value(forKey: "url")             as? String
                    restaurant.image_url    = business.value(forKey: "image_url")       as? String
                    restaurant.phone        = business.value(forKey: "phone")           as? String
                    
                    let address             = (business["location"]    as? [String: Any])?["address1"]  as? String
                    let latitude            = (business["coordinates"] as? [String: Any])?["latitude"]  as? Double
                    let longitude           = (business["coordinates"] as? [String: Any])?["longitude"] as? Double
                    restaurant.address      = address
                    restaurant.latitude     = latitude
                    restaurant.longitude    = longitude
                    
                    restaurantList.append(restaurant)
                }
                
                completion(.success(restaurantList))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}



