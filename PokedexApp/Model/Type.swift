//
//  Type.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 8/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import Foundation

class Type {
    
    var type: PokemonType = .unknown
    var assetImage: String
    var tagImage: String
    var color: Int
    
    init(type: String) {
        switch type {
        case "normal":
            self.type = .normal
            assetImage = "Types-Normal"
            self.tagImage = "Tag-Normal"
            self.color = 0x9A9DA1
            break
        case "fighting":
            self.type = .fighting
            assetImage = "Types-Fight"
            self.tagImage = "Tag-Fight"
            self.color = 0xD94256
            break
        case "flying":
            self.type = .flying
            assetImage = "Types-Flying"
            self.tagImage = "Tag-Flying"
            self.color = 0x9BB4E8
            break
        case "poison":
            self.type = .poison
            assetImage = "Types-Poison"
            self.tagImage = "Tag-Poison"
            self.color = 0xB563CE
            break
        case "ground":
            self.type = .ground
            assetImage = "Types-Ground"
            self.tagImage = "Tag-Ground"
            self.color = 0xD78555
            break
        case "rock":
            self.type = .rock
            assetImage = "Types-Rock"
            self.tagImage = "Tag-Rock"
            self.color = 0xCEC18C
            break
        case "bug":
            self.type = .bug
            assetImage = "Types-Bug"
            self.tagImage = "Tag-Bug"
            self.color = 0x9DC130
            break
        case "ghost":
            self.type = .ghost
            assetImage = "Types-Ghost"
            self.tagImage = "Tag-Ghost"
            self.color = 0x6970C5
            break
        case "steel":
            self.type = .steel
            assetImage = "Types-Steel"
            self.tagImage = "Tag-Steel"
            self.color = 0x5596A4
            break
        case "fire":
            self.type = .fire
            assetImage = "Types-Fire"
            self.tagImage = "Tag-Fire"
            self.color = 0xF8A54F
            break
        case "water":
            self.type = .water
            assetImage = "Types-Water"
            self.tagImage = "Tag-Water"
            self.color = 0x559EDF
            break
        case "grass":
            self.type = .grass
            assetImage = "Types-Grass"
            self.tagImage = "Tag-Grass"
            self.color = 0x5DBE62
            break
        case "electric":
            self.type = .electric
            assetImage = "Types-Electric"
            self.tagImage = "Tag-Electric"
            self.color = 0xEDD53F
            break
        case "psychic":
            self.type = .psychic
            assetImage = "Types-Psychic"
            self.tagImage = "Tag-Psychic"
            self.color = 0xF87C7A
            break
        case "ice":
            self.type = .ice
            assetImage = "Types-Ice"
            self.tagImage = "Tag-Ice"
            self.color = 0x7ED4C9
            break
        case "dragon":
            self.type = .dragon
            assetImage = "Types-Dragon"
            self.tagImage = "Tag-Dragon"
            self.color = 0x0773C7
            break
        case "dark":
            self.type = .dark
            assetImage = "Types-Dark"
            self.tagImage = "Tag-Dark"
            self.color = 0x5F606D
            break
        case "fairy":
            self.type = .fairy
            assetImage = "Types-Fairy"
            self.tagImage = "Tag-NoFairyrmal"
            self.color = 0xEF97E6
            break
        case "shadow":
            self.type = .shadow
            assetImage = "Types-Dark"
            self.tagImage = "Tag-Normal"
            self.color = 0x5F606D
            break
        default:
            self.type = .unknown
            assetImage = ""
            self.tagImage = "Tag-Normal"
            self.color = 0xFFFF
            break
        }
    }
}
