//
//  PokemonTableViewCell.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 8/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonId: UILabel!
    @IBOutlet weak var secondType: UIImageView!
    @IBOutlet weak var firstType: UIImageView!
    
    private let imageHandler = ImageHandler()
    private var _pokemon: Pokemon?
    
    var pokemon:Pokemon? {
        get {
            return _pokemon
        }
        set(newValue) {
            _pokemon = newValue
            //Set the view
            if let pokemon = _pokemon {
                // Pokemon name
                pokemonName.text = pokemon.name.capitalizingFirstLetter()
                // Pokemon id
                pokemonId.text = additionalZeros(id: "\(pokemon.id)")
                //Pokemon image
                if(pokemon.spriteImages.count > 0){
                    let url = URL(string: pokemon.spriteImages[0])
                    imageHandler.getDataOfImage(from: url) { (data, response, error) in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            if(pokemon.id % 3 == 0){
                                self.pokemonImage.contentMode = .scaleAspectFit
                            }else{
                                self.pokemonImage.contentMode = .center
                            }
                            self.pokemonImage.image = UIImage(data: data)
                        }
                    }
                }
                //Pokemon types
                if(pokemon.types.count >= 2){
                    secondType.image = UIImage(named: pokemon.types[1].assetImage)
                    firstType.image = UIImage(named: pokemon.types[0].assetImage)
                }else if(pokemon.types.count == 1){
                    secondType.isHidden = true
                    firstType.image = UIImage(named: pokemon.types[0].assetImage)
                }else{
                    firstType.isHidden = true
                    secondType.isHidden = true
                }
            }
        }
    }
    
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        firstType.isHidden = false
        secondType.isHidden = false
        pokemonImage.image = UIImage(named: "default_img")
        self.pokemonImage.contentMode = .scaleAspectFit
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func additionalZeros(id: String) -> String{
        if(id.count == 1){
            return "#00" + id
        }else if(id.count == 2){
            return "#0" + id
        }
        return "#" + id
    }

}
