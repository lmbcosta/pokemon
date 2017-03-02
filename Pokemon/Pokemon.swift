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
    private var _pokedexID: Int!
    
    var name: String {
        get {
            return _name
        }
    }
    
    var podedexId: Int {
        get {
            return _pokedexID
        }
    }
    
    // Constructor
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexID = podedexId
    }
}
