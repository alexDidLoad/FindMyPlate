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
    static let error        = UIImage(systemName: "wifi.exclamationmark")
    static let globe        = UIImage(systemName: "globe")
    static let indicator    = UIImage(systemName: "chevron.right")
}


enum Icons {
    static let locationIcon = "locationIcon"
    static let yelpIcon     = UIImage(named: "yelp")
}


enum Cuisine: CaseIterable {
    static let cuisines     = ["american", "french", "italian", "mexican", "japanese", "chinese", "vietnamese", "korean"]
    static let americanFood = ["Steak", "Burgers", "Fried Chicken", "Fast Food", "Hot dog", "Salad"]
    static let frenchFood   = ["Pastries", "Steak tartare", "Soufflé", "Raclette", "Cheese Fondue", "Escargot"]
    static let italianFood  = ["Pasta", "Pizza", "Gelato", "Focaccia", "Risotto", "Tiramisu"]
    static let mexicanFood  = ["Tacos", "Burritos", "Ceviche", "Tortas", "Tamales", "Menudo" ]
    static let japaneseFood = ["Sushi", "Ramen", "Udon", "Takoyaki", "Tempura", "Yakitori"]
    static let chineseFood  = ["Peking Duck", "Hot pot", "Dim sum", "Egg Custard Tart", "Fried Rice", "Wonton Soup"]
    static let vietFood     = ["Pho", "Com Tam", "Vietnamese Coffee", "Banh Mi"]
    static let koreanFood   = ["Korean Bbq", "Jjigae", "Bibimbap"]
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
    static let vietnamese    = "Vietnamese Cuisine"
    static let korean        = "Korean Cuisine"
}


enum Body {
    static let whatAreYouFeelingToday = "What type of cuisine are you feeling today?"
    static let whichCategory          = "Which kind of food would you like?"
    static let notAvailable           = "Not Available"
}


enum ErrorMessage {
    static let deniedLocationAuth = "Please enable Location"
    static let goToSettings       = "Settings > Privacy > Location Services > Enable"
    static let invalidURL         = "The url attached to this restaurant is invalid"
    static let errorWithSaving    = "We couldn't save your favorite restaurant 😭"
    static let errorWithFetching  = "We couldn't retrieve your favorite restaurant 😭"
}


enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    
    static let isiPhoneSE = idiom == .phone && ScreenSize.maxLength == 667.0
    static let isiPhone12 = idiom == .phone && ScreenSize.maxLength == 844.0
}


