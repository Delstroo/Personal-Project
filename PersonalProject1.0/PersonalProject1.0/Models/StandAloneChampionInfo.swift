//
//  StandAloneChampionInfo.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 2/10/22.
//

import Foundation

struct StandAloneTopLevelObject: Decodable {
    let data: [String:ChampionData]
    
}// End of struct

struct ChampionData: Codable {
    let id: String
    let name: String
    let title: String
    let image: Image
    let skins: [Skins]
    let lore: String
    let blurb: String
    let allytips: [String]
    let enemytips: [String]
    let tags: [String]
    let spells: [Spells]
    
}// End of struct

struct Image: Codable {
    let full: String
    let sprite: String
    let group: String
    
}// End of struct

struct Skins: Codable {
    let id: String
    let name: String
    
}// End of struct

struct Spells: Codable {
    let id: String
    let name: String
    let description: String
    let tooltip: String
    let image: SpellImage
    
}// End of struct

struct SpellImage: Codable {
    let full: String
    let sprite: String
    let group: String
    
}// End of struct
