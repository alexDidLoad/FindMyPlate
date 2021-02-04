//
//  FMPError.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 2/3/21.
//

import Foundation

enum FMPError: String, Error {
    case unableToComplete   = "Unable to complete your request. Please check your internet"
    case invalidResponse    = "Invalid response from the server. Please try again"
    case invalidData        = "The data received from the server was invalid. Please try again"
    case alreadyInFavorites = "This restaurant is already in your favorites! You must REALLY like them 🥰"
}

