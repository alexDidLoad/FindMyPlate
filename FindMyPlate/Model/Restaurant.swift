//
//  Restaurant.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/3/21.
//

import Foundation

struct Restaurant: Codable {
    
    var uuid = UUID()
    
    var name            : String?
    var id              : String?
    var rating          : Float?
    var price           : String?
    var is_closed       : Bool?
    var distance        : Double?
    var address         : String?
    var latitude        : Double?
    var longitude       : Double?
    var url             : String?
    var image_url       : String?
    var phone           : String?
}

extension Restaurant: Hashable {
    
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    
}
