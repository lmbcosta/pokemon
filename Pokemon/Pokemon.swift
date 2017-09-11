//
//  Pokemon.swift
//  Pokemon
//
//  Created by Luis  Costa on 02/03/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _podedexId: Int!
    
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAtack: String!
    private var _pokemonURL: String!
    private var _nextEvolution: String!
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._podedexId = pokedexId
        self._pokemonURL = URL_BASE_POKEMON + "\(self.pokedex)"
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var baseAttack: String {
        if _baseAtack == nil {
            _baseAtack = ""
        }
        return _baseAtack
    }
    
    var nextEvolution: String {
        if _nextEvolution == nil {
            _nextEvolution = ""
        }
        return _nextEvolution
    }
    
    var name: String {
        return _name
    }
    
    var pokedex: Int {
        return _podedexId
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        if let url = URL(string: _pokemonURL) {
            Alamofire.request(url).responseJSON{ response in
                if let json = response.result.value as? Dictionary<String, Any> {
                    // Get defense
                    if let defense = json["defense"] as? Int {
                        self._defense = "\(defense)"
                        print(self._defense)
                    }
                    // Get height
                    if let height = json["height"] as? String {
                        self._height = height
                        print(self._height)
                    }
                    // Get weight
                    if let weight = json["weight"] as? String {
                        self._weight = weight
                        print(self._weight)
                    }
                    // Get attack
                    if let attack = json["attack"] as? Int {
                        self._baseAtack = "\(attack)"
                        print(self._baseAtack)
                    }
                }
                completed()
            }
        }
    }
}
