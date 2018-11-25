//
//  BeerVO.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/11/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
struct BeerVO: Codable {
    var id: Int
    var name, tagline, firstBrewed, description: String
    var imageURL: String
    var abv: Double
    var ibu: Double?
    var targetFg: Int
    var targetOg: Double
    var ebc: Int?
    var srm, ph: Double?
    var attenuationLevel: Double?
    var volume: BoilVolume? = nil
    var boilVolume: BoilVolume? = nil
    var method: Method?
    var ingredients: Ingredients?
    var foodPairing: [String]
    var brewersTips: String
    var contributedBy: ContributedBy?
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method, ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
    
    
}

struct BoilVolume: Codable {
    let value: Double
    let unit: Unit
}

enum Unit: String, Codable {
    case celsius = "celsius"
    case grams = "grams"
    case kilograms = "kilograms"
    case liters = "liters"
}

enum ContributedBy: String, Codable {
    case aliSkinnerAliSkinner = "Ali Skinner <AliSkinner>"
    case samMasonSamjbmason = "Sam Mason <samjbmason>"
}

struct Ingredients: Codable {
    var malt: [Malt]
    var hops: [Hop]
    var yeast: String
}

struct Hop: Codable {
    var name: String
    var amount: BoilVolume
    var add: Add
    var attribute: Attribute
}

enum Add: String, Codable {
    case dryHop = "dry hop"
    case end = "end"
    case middle = "middle"
    case start = "start"
}

enum Attribute: String, Codable {
    case aroma = "aroma"
    case bitter = "bitter"
    case empty = ""
    case flavour = "flavour"
}

struct Malt: Codable {
    var name: String
    var amount: BoilVolume
}

struct Method: Codable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

struct Fermentation: Codable {
    let temp: BoilVolume
}

struct MashTemp: Codable {
    let temp: BoilVolume
    let duration: Int?
}
