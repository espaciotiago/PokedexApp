//
//  ViewController.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 8/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController,UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    let pokemonViewModel = PokemonViewModel()
    var nextUrl:String?
    var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        searchController.searchResultsUpdater = self
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        pokemonViewModel.getPokemons(url: nil) { (completed, message, pokemonList) in
            if(completed){
                self.nextUrl = message
                if let pokemonsData = pokemonList {
                    self.pokemons = pokemonsData
                    self.pokemonTableView.reloadData()
                }
            }else{
                //Show error
            }
            self.loading.stopAnimating()
        }
    }
    //----------------------------------------------------------------
    // MARK: - Table veiw methods
    //----------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as! PokemonTableViewCell
        cell.pokemon = pokemons[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController{
            viewController.pokemon = pokemons[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == pokemons.count {
            self.loading.startAnimating()
            //Load the other data
            if let nextUrlReq = self.nextUrl {
                pokemonViewModel.getPokemons(url: nextUrlReq) { (completed, message, pokemonList) in
                    if(completed){
                        self.nextUrl = message
                        if let pokemonsData = pokemonList {
                            self.pokemons.append(contentsOf: pokemonsData)
                            self.pokemonTableView.reloadData()
                        }
                    }else{
                        //Show error
                    }
                    self.loading.stopAnimating()
                }
            }
        }
    }
    //----------------------------------------------------------------
    // MARK: - Search bar - Search for a pokemon
    //----------------------------------------------------------------
    func updateSearchResults(for searchController: UISearchController) {
        let searchBarContent = searchController.searchBar.text
        //Do the search
    }
}

