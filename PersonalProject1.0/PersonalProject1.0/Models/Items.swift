//
//  Items.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/2/21.
//

import Foundation

struct TheTopLevelObject: Codable {
    let data: [String: Items]
}// End of struct

struct Items: Codable {
    let name: String
    let description: String
    let plaintext: String
    let image: ItemImage
    let gold: ItemGold
    let stats: ItemStats
}// End of struct

struct ItemImage: Codable {
    let full: String
    let sprite: String
    
}// End of struct

struct ItemGold: Codable {
    let base: Int
    let total: Int
    let sell: Int
    
}// End of struct

struct ItemStats: Codable {
    //let FlatMovementSpeedMod: Int
    
}// End of struct
