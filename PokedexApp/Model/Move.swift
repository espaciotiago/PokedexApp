//
//  Move.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 9/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import Foundation

class Move {
    var name: String
    var type: Type
    
    init(name: String?, type: Type?) {
        self.name = name ?? ""
        self.type = type ?? Type(type: "")
    }
}
