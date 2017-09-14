//
//  PokemonDetailVC.swift
//  Pokemon
//
//  Created by Luis  Costa on 09/09/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalized
        mainImage.image = UIImage(named: "\(pokemon.pokedex)")
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedex)")

        pokemon.downloadPokemonDetails {
            // Update UI from the detail view
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        descriptionLabel.text = pokemon.desc
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        pokedexLabel.text = "\(pokemon.pokedex)"
        weightLabel.text = pokemon.weight
        baseAttackLabel.text = pokemon.baseAttack
        if pokemon.nextEvoId == "" {
            evolutionLabel.text = "No Evolution"
            nextEvoImg.isHidden = true
        } else {
            let evoText = "Next Evolution: \(pokemon.nextEvolutionName) Level: \(pokemon.nextEvoLevel)"
            evolutionLabel.text = evoText
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            nextEvoImg.isHidden = false
        }
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedex)")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
