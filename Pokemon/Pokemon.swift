//
//  Pokemon.swift
//  Pokemon
//
//  Created by Luis  Costa on 02/03/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _podedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedex: Int {
        return _podedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._podedexId = pokedexId
    }
}
