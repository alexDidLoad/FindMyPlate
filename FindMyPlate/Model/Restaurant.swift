//
//  Restaurant.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/3/21.
//

import Foundation

struct Restaurant: Codable {
    
    var uuid = UUID()
    
    var id              : String?
    var name            : String?
    var rating          : Float?
    var reviewCount     : Int?
    var price           : String?
    var isClosed        : Bool?
    var address         : String?
    var latitude        : Double?
    var longitude       : Double?
    var url             : String?
    var imageUrl        : String?
    var phone           : String?
}

extension Restaurant: Hashable {

    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }


}
