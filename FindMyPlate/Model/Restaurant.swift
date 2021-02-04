//
//  Restaurant.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/3/21.
//

import Foundation

struct Restaurant: Codable {
    var name            : String?
    var id              : String?
    var rating          : Float?
    var price           : String?
    var isClosed        : Bool?
    var distance        : Double?
    var address         : String?
    var latitude        : Double?
    var longitude       : Double?
    var url             : String?
    var imageUrl        : String?
    var phone           : String?
}
