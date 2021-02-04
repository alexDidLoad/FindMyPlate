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
    
    private let baseURL = "https://api.yelp.com/"
    private let apiKey  = "nWw_wNDWE2ePm7iYF7x6ovwGfZrOeL_Rxf1IKqRbm66cF2Og6D-vhMYOrqgCMS_DajR0eGwEetArAKQ6UTtcMnDOXoS1s96TIFUg4sV07QRaQBJYT3l_pNTUJR0BYHYx"
    
    //MARK: - Lifecycle
    
    private init() {}
    
    //MARK: - Helpers
    
    func getRestaurants(from request: URLRequest, completion: @escaping (Result<[Restaurant], FMPError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let restaurants = try decoder.decode([Restaurant].self, from: data)
                completion(.success(restaurants))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func requestYelpData(withPhoneNumber phone: String) {
        
        guard let url = URL(string: baseURL + "v3/businesses/search/phone?phone=\(phone)") else { return }
        
        var request   = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        getRestaurants(from: request) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let restaurants):
                print(restaurants)
            case .failure(let error):
                print(error.rawValue)
            }
            
        }
    }
    
}



