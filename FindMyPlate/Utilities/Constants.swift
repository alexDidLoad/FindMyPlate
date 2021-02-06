//
//  Constants.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/30/21.
//

import UIKit

enum SFSymbols {
    static let home         = UIImage(systemName: "house.fill")
    static let heart        = UIImage(systemName: "heart.fill")
    static let questionmark = UIImage(systemName: "questionmark")
    static let paperPlane   = UIImage(systemName: "paperplane.fill")
    static let xmark        = UIImage(systemName: "xmark.circle.fill")
    static let car          = UIImage(systemName: "car.fill")
}


enum Lottie {
    static let locationIcon = "locationIcon"
}


enum Cuisine: CaseIterable {
    static let cuisines     = ["american", "french", "italian", "mexican", "japanese", "chinese", "thai", "korean"]
    static let americanFood = ["steak", "burgers", "fried chicken", "fast food", "hot dog", "salad"]
    static let frenchFood   = ["Pastries", "French Bistro", "Wine and Cheese"]
    static let italianFood  = ["Pasta", "Pizza", "Gelato", ]
    static let mexicanFood  = ["Tacos", "Burritos", "Elote", "Mole", "Tamales" ]
    static let japaneseFood = ["Sushi", "Ramen", "Udon", "Japanese Curry", "Tempura"]
    static let chineseFood  = ["Fried Rice", "Hot pot", "Dim sum", "Chinese Noodles"]
    static let thaiFood     = ["Tom yum soup", "Pad Thai", "Thai Curry"]
    static let koreanFood   = ["Korean Bbq", "Bulgogi", "Korean Stew", "Bibimbap", "Jap chae"]
}


enum Title {
    static let fmp           = "Find My Plate"
    static let chooseCuisine = "Choose a Cuisine"
    static let american      = "American Cuisine"
    static let french        = "French Cuisine"
    static let italian       = "Italian Cuisine"
    static let mexican       = "Mexican Cuisine"
    static let japanese      = "Japanese Cuisine"
    static let chinese       = "Chinese Cuisine"
    static let thai          = "Thai Cuisine"
    static let korean        = "Korean Cuisine"
}


enum Body {
    static let whatAreYouFeelingToday = "What type of cuisine are you feeling today?"
    static let whichCategory          = "Which category of food would you like?"
    static let notAvailable           = "N/A"
}


enum LocationErrorMessage {
    static let deniedLocationAuth = "Please enable Location"
    static let goToSettings       = "Settings > Privacy > Location Services > Enable"
}
