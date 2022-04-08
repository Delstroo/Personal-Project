//
//  Builds.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/9/21.
//

import UIKit

class Build: Codable {
    
    var title: String
    var itemOne: Items?
    var itemTwo: Items?
    var itemThree: Items?
    var itemFour: Items?
    var itemFive: Items?
    var itemSix: Items?
    var championButton: ChampionInfo?
    let uuid: String
    
    init(title: String, itemOne: Items? = nil, itemTwo: Items? = nil, itemThree: Items? = nil, itemFour: Items? = nil, itemFive: Items? = nil, itemSix: Items? = nil, championButton: ChampionInfo? = nil, uuid: String = UUID().uuidString) {
        
        self.title = title
        self.itemOne = itemOne
        self.itemTwo = itemTwo
        self.itemThree = itemThree
        self.itemFour = itemFour
        self.itemFive = itemFive
        self.itemSix = itemSix
        self.championButton = championButton
        self.uuid = uuid
    }
    
}

extension Build: Equatable {
    static func == (lhs: Build, rhs: Build) -> Bool{
        return lhs.uuid == rhs.uuid
        
    }
}
