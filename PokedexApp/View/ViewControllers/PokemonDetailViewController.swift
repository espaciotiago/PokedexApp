//
//  PokemonDetailViewController.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 8/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Pokemon info
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var firstTypeImage: UIImageView!
    @IBOutlet weak var secondTypeImage: UIImageView!
    //Buttons tabs
    @IBOutlet weak var btnStats: UIButton!
    @IBOutlet weak var btnEvolutions: UIButton!
    @IBOutlet weak var btnMoves: UIButton!
    //Stats view
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var hpValue: UILabel!
    @IBOutlet weak var atkLabel: UILabel!
    @IBOutlet weak var atkValue: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var defValue: UILabel!
    @IBOutlet weak var satkLabel: UILabel!
    @IBOutlet weak var satkValue: UILabel!
    @IBOutlet weak var sdefLabel: UILabel!
    @IBOutlet weak var sdefValue: UILabel!
    @IBOutlet weak var spdLabel: UILabel!
    @IBOutlet weak var spdValue: UILabel!
    @IBOutlet weak var hpProgress: UIProgressView!
    @IBOutlet weak var atkProgress: UIProgressView!
    @IBOutlet weak var defProgress: UIProgressView!
    @IBOutlet weak var satkProgress: UIProgressView!
    @IBOutlet weak var sdefProgress: UIProgressView!
    @IBOutlet weak var spdProgress: UIProgressView!
    //Moves and Evolution view
    @IBOutlet weak var movesTable: UITableView!
    
    
    private let imageHandler = ImageHandler()
    var pokemon: Pokemon?
    var mainColor:UIColor = UIColor(rgb: 0xFFFF)
    var selectedTab:ActionTab = .stats
    var moves = [Move]()
    var pokemonEvolutions = [Pokemon]()
    let pokemonViewModel = PokemonViewModel()
    var currentPos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGeneralView()
        setUpPokemonInfo()
        setUpButtons()
        setUpStatsView()
    }
    //----------------------------------------------------------------------
    // MARK: - Views setup
    //----------------------------------------------------------------------
    func setUpGeneralView(){
        //Configure the navbar and the main view
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        infoView.layer.cornerRadius = 25
        btnStats.layer.cornerRadius = 10
        btnEvolutions.layer.cornerRadius = 10
        btnMoves.layer.cornerRadius = 10
        movesTable.delegate = self
        movesTable.dataSource = self
    }
    //----------------------------------------------------------------------
    func setUpStatsView(){
        //HP
        hpProgress.layer.cornerRadius = 10
        hpProgress.clipsToBounds = true
        hpProgress.tintColor = mainColor
        hpLabel.textColor = mainColor
        let hpVal = pokemon?.getBaseStats(statsName: "hp") ?? 0
        hpValue.text = "\(hpVal)"
        hpProgress.progress = Float(hpVal/100)
        //ATK
        atkProgress.layer.cornerRadius = 10
        atkProgress.clipsToBounds = true
        atkProgress.tintColor = mainColor
        atkLabel.textColor = mainColor
        let atkVal = pokemon?.getBaseStats(statsName: "attack") ?? 0
        atkValue.text = "\(atkVal)"
        atkProgress.progress = Float(atkVal/100)
        //DEF
        defProgress.layer.cornerRadius = 10
        defProgress.clipsToBounds = true
        defProgress.tintColor = mainColor
        defLabel.textColor = mainColor
        let defVal = pokemon?.getBaseStats(statsName: "defense") ?? 0
        defValue.text = "\(defVal)"
        defProgress.progress = Float(defVal/100)
        //SATK
        satkProgress.layer.cornerRadius = 10
        satkProgress.clipsToBounds = true
        satkProgress.tintColor = mainColor
        satkLabel.textColor = mainColor
        let satkVal = pokemon?.getBaseStats(statsName: "special-attack") ?? 0
        satkValue.text = "\(satkVal)"
        satkProgress.progress = Float(satkVal/100)
        //SDEF
        sdefProgress.layer.cornerRadius = 10
        sdefProgress.clipsToBounds = true
        sdefProgress.tintColor = mainColor
        sdefLabel.textColor = mainColor
        let sdefVal = pokemon?.getBaseStats(statsName: "special-defense") ?? 0
        sdefValue.text = "\(sdefVal)"
        sdefProgress.progress = Float(sdefVal/100)
        //SPD
        spdProgress.layer.cornerRadius = 10
        spdProgress.clipsToBounds = true
        spdProgress.tintColor = mainColor
        spdLabel.textColor = mainColor
        let spdVal = pokemon?.getBaseStats(statsName: "speed") ?? 0
        spdValue.text = "\(spdVal)"
        spdProgress.progress = Float(spdVal/100)
        loading.stopAnimating()
    }
    //----------------------------------------------------------------------
    func setUpPokemonInfo(){
        //Configure the views according the pokeon
        if let pokemonOjb = pokemon {
            // Types stuffs
            if(pokemonOjb.types.count > 0){
                //Background view
                self.mainColor = UIColor(rgb: pokemonOjb.types[0].color)
                self.navigationController?.navigationBar.barTintColor = mainColor
                self.view.backgroundColor = mainColor
                if(pokemonOjb.types.count >= 2){
                    self.firstTypeImage.image = UIImage(named: pokemonOjb.types[0].tagImage)
                    self.secondTypeImage.image = UIImage(named: pokemonOjb.types[1].tagImage)
                }else{
                    self.secondTypeImage.isHidden = true
                    self.firstTypeImage.image = UIImage(named: pokemonOjb.types[0].tagImage)
                }
            }else{
                self.firstTypeImage.isHidden = true
                self.secondTypeImage.isHidden = true
            }
            //Image
            if(pokemonOjb.spriteImages.count > 0){
                let url = URL(string: pokemonOjb.spriteImages[0])
                imageHandler.getDataOfImage(from: url) { (data, response, error) in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        self.pokemonImage.image = UIImage(data: data)
                    }
                }
            }
            //Name
            pokemonName.text = pokemonOjb.name.capitalizingFirstLetter()
        }
    }
    //----------------------------------------------------------------------
    func setUpButtons(){
        switch selectedTab {
        case .stats:
            btnStats.tintColor = UIColor(rgb: 0xFFFFFF)
            btnStats.backgroundColor = mainColor
            btnEvolutions.tintColor = mainColor
            btnEvolutions.backgroundColor = UIColor(white: 1, alpha: 0.0)
            btnMoves.tintColor = mainColor
            btnMoves.backgroundColor = UIColor(white: 1, alpha: 0.0)
            statsView.isHidden = false
            movesTable.isHidden = true
            break
        case .evolutions:
            btnEvolutions.tintColor = UIColor(rgb: 0xFFFFFF)
            btnEvolutions.backgroundColor = mainColor
            btnStats.tintColor = mainColor
            btnStats.backgroundColor = UIColor(white: 1, alpha: 0.0)
            btnMoves.tintColor = mainColor
            btnMoves.backgroundColor = UIColor(white: 1, alpha: 0.0)
            statsView.isHidden = true
            movesTable.isHidden = false
            break
        case .moves:
            btnMoves.tintColor = UIColor(rgb: 0xFFFFFF)
            btnMoves.backgroundColor = mainColor
            btnEvolutions.tintColor = mainColor
            btnEvolutions.backgroundColor = UIColor(white: 1, alpha: 0.0)
            btnStats.tintColor = mainColor
            btnStats.backgroundColor = UIColor(white: 1, alpha: 0.0)
            statsView.isHidden = true
            movesTable.isHidden = false
            break
        }
    }
    
    //----------------------------------------------------------------------
    // MARK: - Actions
    //----------------------------------------------------------------------
    @IBAction func statsSelected(_ sender: Any) {
        selectedTab = .stats
        setUpButtons()
        loading.stopAnimating()
    }
    //----------------------------------------------------------------------
    @IBAction func evolutionsSelected(_ sender: Any) {
        selectedTab = .evolutions
        setUpButtons()
        loading.startAnimating()
        if(pokemonEvolutions.count <= 0){
            pokemonEvolutions = [Pokemon]()
            pokemonViewModel.getSpeciesInfo(url: pokemon?.species.url) { (speciesList) in
                var pokemonListOfNames = [String]()
                var pokemons = [Pokemon]()
                speciesList.forEach { (species) in
                    pokemonListOfNames.append(species.name)
                }
                pokemons.append(contentsOf: self.pokemonViewModel.getPokemonsFromList(listOfNames: pokemonListOfNames))
                self.pokemonEvolutions.append(contentsOf: pokemons)
                self.movesTable.reloadData()
                self.loading.stopAnimating()
            }
        }else{
            self.movesTable.reloadData()
            loading.stopAnimating()
        }
    }
    //----------------------------------------------------------------------
    @IBAction func movesSelected(_ sender: Any) {
        selectedTab = .moves
        setUpButtons()
        loading.startAnimating()
        //Load the moves data
        if(moves.count <= 0){
            if let movesUrls = pokemon?.movesUrls {
                let movesData = pokemonViewModel.getMoves(urls: movesUrls, pos: currentPos)
                moves = movesData
                movesTable.reloadData()
                loading.stopAnimating()
            }
        }else{
            movesTable.reloadData()
            loading.stopAnimating()
        }
    }
    //----------------------------------------------------------------------
    // MARK: - Tableview moves
    //----------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(selectedTab == .moves){
            return moves.count
        }else{
            return pokemonEvolutions.count
        }
    }
    //----------------------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(selectedTab == .moves){
            return 80
        }else{
            return 110
        }
    }
    //----------------------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(selectedTab == .moves){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoveTableViewCell") as! MoveTableViewCell
            cell.move = moves[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EvolutionTableViewCell") as! EvolutionTableViewCell
            cell.mainPokemon = pokemonEvolutions[indexPath.row]
            if(pokemonEvolutions.count > indexPath.row + 1){
                cell.evolutionPokemon = pokemonEvolutions[indexPath.row+1]
            }else{
                cell.isHidden = true
            }
            return cell
        }
    }
    //----------------------------------------------------------------------
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(selectedTab == .moves){
            if indexPath.row + 1 == moves.count {
                loading.startAnimating()
                self.currentPos = self.currentPos + 5
                if let movesUrls = pokemon?.movesUrls {
                    let movesData = pokemonViewModel.getMoves(urls: movesUrls, pos: currentPos)
                    if(!movesData.isEmpty){
                        moves.append(contentsOf: movesData)
                        movesTable.reloadData()
                        loading.stopAnimating()
                    }
                }
            }
        }
    }
}
