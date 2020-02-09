//
//  EvolutionTableViewCell.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 9/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import UIKit

class EvolutionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainPokemonImage: UIImageView!
    @IBOutlet weak var evolutionPokemonImage: UIImageView!
    @IBOutlet weak var mainPokemonName: UILabel!
    @IBOutlet weak var evolutionPokemnName: UILabel!
    
    private let imageHandler = ImageHandler()
    var _mainPokemon: Pokemon?
    var _evolutionPokemon: Pokemon?
    
    var mainPokemon: Pokemon? {
        get {
            return _mainPokemon
        }
        set (newValue){
            _mainPokemon = newValue
            if let pokemon = _mainPokemon{
                //Set the name
                mainPokemonName.text = pokemon.name.capitalizingFirstLetter()
                //Set the image
                if(pokemon.spriteImages.count > 0){
                    let url = URL(string: pokemon.spriteImages[0])
                    imageHandler.getDataOfImage(from: url) { (data, response, error) in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            if(pokemon.id % 3 == 0){
                                self.mainPokemonImage.contentMode = .scaleAspectFit
                            }else{
                                self.mainPokemonImage.contentMode = .center
                            }
                            self.mainPokemonImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    var evolutionPokemon: Pokemon? {
        get {
            return _evolutionPokemon
        }
        set (newValue){
            _evolutionPokemon = newValue
            if let pokemon = _evolutionPokemon{
                //Set the name
                evolutionPokemnName.text = pokemon.name.capitalizingFirstLetter()
                //Set the image
                if(pokemon.spriteImages.count > 0){
                    let url = URL(string: pokemon.spriteImages[0])
                    imageHandler.getDataOfImage(from: url) { (data, response, error) in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            if(pokemon.id % 3 == 0){
                                self.evolutionPokemonImage.contentMode = .scaleAspectFit
                            }else{
                                self.evolutionPokemonImage.contentMode = .center
                            }
                            self.evolutionPokemonImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
