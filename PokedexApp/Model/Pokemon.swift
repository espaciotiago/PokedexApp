//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 8/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import Foundation

class Pokemon{
    
    var id: Int
    var name: String
    var spriteImages: [String]
    var movesUrls: [String]
    var types: [Type]
    var stats: [Stats]
    var species: Species
    
    init(id: Int, name: String?, spriteImages: [String]?, types: [Type]?, stats: [Stats]?, movesUrls: [String], species: Species){
        self.id = id
        self.name = name ?? ""
        self.spriteImages = spriteImages ?? [String]()
        self.types = types ?? [Type]()
        self.stats = stats ?? [Stats]()
        self.movesUrls = movesUrls
        self.species = species
    }
    
    public func getBaseStats(statsName: String) -> Double{
        var base = 0.0
        self.stats.forEach { (stat) in
            if(stat.name.elementsEqual(statsName)){
                base = stat.base
                return
            }
        }
        return base
    }
}
