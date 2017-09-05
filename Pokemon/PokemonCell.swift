//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Luis  Costa on 05/09/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func configureCell(pokemon: Pokemon) {
        thumbImage.image = UIImage(named: "\(pokemon.pokedex)")
        name.text = pokemon.name
    }
   
    
}
