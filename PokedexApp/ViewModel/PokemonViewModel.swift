//
//  PokemonViewModel.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 8/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_Synchronous

let API_BASE = "https://pokeapi.co/api/v2"
let API_POKEMON = "\(API_BASE)/pokemon"

class PokemonViewModel{
    var species = [Species]()
    
    //------------------------------------------------------------------
    // Get the list of pokemons
    func getPokemons(url: String?, _ completion: @escaping(Bool, String?, [Pokemon]?) -> Void){
        var pokemonList = [Pokemon]()
        var urlReq = API_POKEMON
        if let urlTemp = url {
            urlReq = urlTemp
        }
        Alamofire.request(urlReq).responseJSON { response in
            switch(response.result){
            case .success(let value):
                //Get the response object
                guard let object = value as? NSDictionary else {
                    completion(false, "We are sorry, an error has ocurred", nil)
                    return
                }
                let nextUrl = object["next"] as? String
                //Get the results
                guard let results = object["results"] as? NSArray else {
                    completion(false, "We are sorry, an error has ocurred", nil)
                    return
                }
                //Get the info of the pokemon on every result
                results.forEach { (pokemonInfo) in
                    if let pokemonObject = pokemonInfo as? NSDictionary {
                        if let pokemonUrl = pokemonObject["url"] as? String {
                            //Get the pokemon info
                            if let pokemon = self.getPokemonDetails(url: pokemonUrl){
                                //Add it to the list
                                pokemonList.append(pokemon)
                            }
                        }
                    }
                }
                completion(true,nextUrl,pokemonList)
                
                break
            case .failure( _):
                completion(false, "We are sorry, an error has ocurred", nil)
            }
        }
    }
    //------------------------------------------------------------------
    // Get the details of one pokemon
    func getPokemonDetails(url: String) -> Pokemon? {
        let response = Alamofire.request(url).responseJSON()
        if let json = response.result.value as? NSDictionary {
            //Get the pokemon info
            let pokemonId = json["id"] as? Int ?? 0
            let pokemonName = json["name"] as? String ?? ""
            let statsArray = json["stats"] as? NSArray
            let typesArray = json["types"] as? NSArray
            let movesArray = json["moves"] as? NSArray
            let speciesObject = json["species"] as? NSDictionary
            //Create the sprites list
            var pokemonSprites = [String]()
            if let sriptes = json["sprites"] as? NSDictionary {
                if let frontDefault = sriptes["front_default"] as? String {
                    pokemonSprites.append(frontDefault)
                }
                if let frontShiny = sriptes["front_shiny"] as? String {
                    pokemonSprites.append(frontShiny)
                }
                if let backDefault = sriptes["back_default"] as? String {
                    pokemonSprites.append(backDefault)
                }
                if let backFemale = sriptes["back_female"] as? String {
                    pokemonSprites.append(backFemale)
                }
                if let backShiny = sriptes["back_shiny"] as? String {
                    pokemonSprites.append(backShiny)
                }
                if let backShinyFemale = sriptes["back_shiny_female"] as? String {
                    pokemonSprites.append(backShinyFemale)
                }
                if let frontFemale = sriptes["front_female"] as? String {
                    pokemonSprites.append(frontFemale)
                }
                if let frontShinyFemale = sriptes["front_shiny_female"] as? String {
                    pokemonSprites.append(frontShinyFemale)
                }
            }
            //Create the types list
            var pokemonTypes = [Type]()
            typesArray?.forEach({ (pokeType) in
                if let typeObject = pokeType as? NSDictionary {
                    if let typeInfo = typeObject["type"] as? NSDictionary {
                        let typeName = typeInfo["name"] as? String ?? ""
                        let typeCreated = Type(type: typeName)
                        pokemonTypes.append(typeCreated)
                    }
                }
            })
            //Create the stats list
            var pokemonStats = [Stats]()
            statsArray?.forEach({ (pokeStats) in
                if let statsObject = pokeStats as? NSDictionary {
                    let statBase = statsObject["base_stat"] as? Double ?? 0
                    if let statsInfo = statsObject["stat"] as? NSDictionary {
                        let statName = statsInfo["name"] as? String ?? ""
                        let statCreated = Stats(name: statName, base: statBase)
                        pokemonStats.append(statCreated)
                    }
                }
            })
            //Create the moves urls list
            var pokemonMoves = [String]()
            movesArray?.forEach({ (move) in
                if let moveDir = move as? NSDictionary {
                    if let moveInfo = moveDir["move"] as? NSDictionary {
                        if let moveUrl = moveInfo["url"] as? String {
                            pokemonMoves.append(moveUrl)
                        }
                    }
                }
            })
            //Create the species
            var species = Species(name: nil,url: nil)
            if let speciesInfo = speciesObject {
                species = Species(name: speciesInfo["name"] as? String,url: speciesInfo["url"] as? String)
            }
            //Create and return the pokemon object
            let pokemon = Pokemon(id: pokemonId, name: pokemonName, spriteImages: pokemonSprites, types: pokemonTypes, stats: pokemonStats, movesUrls: pokemonMoves,species: species)
            return pokemon
        }
        return nil
    }
    //------------------------------------------------------------------
    // Get the moves of the pokemon moves list
    func getMoves(urls: [String], pos: Int) -> [Move]{
        var moves = [Move]()
        let length = pos + 5
        if(urls.count >= length){
            for i in pos...length {
                if(urls.count > i){
                    let url = urls[i]
                    if let move = getMove(url: url) {
                        moves.append(move)
                    }
                }
            }
        }
        return moves
    }
    //------------------------------------------------------------------
    // Get the move info
    func getMove(url: String) -> Move? {
        let response = Alamofire.request(url).responseJSON()
        if let json = response.result.value as? NSDictionary {
            let name = json["name"] as? String ?? ""
            var typeName = ""
            if let type = json["type"] as? NSDictionary {
                if let tName = type["name"] as? String {
                    typeName = tName
                }
            }
            let typeCreated = Type(type: typeName)
            let moveCreated = Move(name: name, type: typeCreated)
            return moveCreated
        }
        return nil
    }
    //------------------------------------------------------------------
    // Get the species info
    func getSpeciesInfo(url: String?, _ completion: @escaping([Species]) -> Void){
        if let urlReg = url {
            Alamofire.request(urlReg).responseJSON { response in
                switch(response.result){
                case .success(let value):
                    //Get the response object
                    guard let object = value as? NSDictionary else {
                        return
                    }
                    if let evolutionChainObject = object["evolution_chain"] as? NSDictionary {
                        if let evolutionChainUrl = evolutionChainObject["url"] as? String {
                            self.getEvolutionChain(url: evolutionChainUrl) { (species) in
                                completion(species)
                            }
                        }
                    }
                    break
                case .failure( _):
                    break
                }
            }
        }else{
            
        }
    }
    
    //------------------------------------------------------------------
    // Get the evolution chain
    func getEvolutionChain(url: String, _ completion: @escaping([Species]) -> Void){
        let response = Alamofire.request(url).responseJSON()
        if let json = response.result.value as? NSDictionary {
            if let chain = json["chain"] as? NSDictionary {
                if let speciesObj = chain["species"] as? NSDictionary {
                    let speciesCreated = Species(name: speciesObj["name"] as? String, url: speciesObj["url"] as? String)
                    self.species.append(speciesCreated)
                }
                getEvolvesTo(chain: chain) { (species) in
                    completion(species)
                }
            }
        }
    }
    //------------------------------------------------------------------
    // Get the evolution recursive
    func getEvolvesTo(chain: NSDictionary, _ completion: @escaping([Species]) -> Void){
        if let evolvesTo = chain["evolves_to"] as? NSArray {
            if(evolvesTo.count > 0){
                if let evolvesObj = evolvesTo[0] as? NSDictionary {
                    //Get the species
                    if let speciesObj = evolvesObj["species"] as? NSDictionary {
                        let speciesCreated = Species(name: speciesObj["name"] as? String, url: speciesObj["url"] as? String)
                        self.species.append(speciesCreated)
                    }
                    //Get the other evolves to
                    getEvolvesTo(chain: evolvesObj) { (species) in
                        completion(species)
                    }
                }
            }else{
                //Stop asking
                completion(species)
            }
        }
    }
    //------------------------------------------------------------------
    // Get pokemons from list of names
    func getPokemonsFromList(listOfNames: [String]) -> [Pokemon]{
        var pokemons = [Pokemon]()
        listOfNames.forEach { (pokemonName) in
            let url = "\(API_POKEMON)/\(pokemonName)"
            if let pokemon = self.getPokemonDetails(url: url){
                pokemons.append(pokemon)
            }
        }
        return pokemons
    }
}
