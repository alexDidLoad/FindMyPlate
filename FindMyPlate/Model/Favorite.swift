//
//  Favorite.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/7/21.
//

import Foundation

struct Favorite: Codable, Hashable {
    
    var name            : String?
    var rating          : Float?
    var reviewCount     : Int?
    var address         : String?
    var url             : String?
    var imageUrl        : String?
    var phone           : String?
}
