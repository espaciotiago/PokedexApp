//
//  Species.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 9/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import Foundation

class Species{
    var name: String
    var url: String
        
    init(name: String?, url: String?){
        self.name = name ?? ""
        self.url = url ?? ""
    }
}
