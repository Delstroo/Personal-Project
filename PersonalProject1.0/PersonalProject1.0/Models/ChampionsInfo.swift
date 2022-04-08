//
//  ChampionsInfo.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 8/22/21.
//

import Foundation

struct TopLevelObject: Codable {
    let data: [String: ChampionInfo]
}// End of struct

struct ChampionInfo: Codable {
    let name: String
    let title: String
    let blurb: String
    let key: String
    let id: String
    let image: ChampionImage
    var stats: ChampionStats
}// End of struct

struct ChampionImage: Codable {
    let full: String
    let sprite: String
}// End of struct

struct ChampionStats: Codable {
    var hp: Double
    let hpperlevel: Double
    let hpregen: Double
    let hpregenperlevel: Double
    let mp: Double
    let mpregen: Double
    let mpregenperlevel: Double
    let mpperlevel: Double
    let attackdamage: Double
    let attackdamageperlevel: Double
    let attackspeed: Double
    let attackspeedperlevel: Double
    let movespeed: Double
    let armor: Double
    let armorperlevel: Double
    let spellblock : Double
    let spellblockperlevel: Double
    let attackrange: Double
    let crit: Double
    let critperlevel: Double

}// End of struct


