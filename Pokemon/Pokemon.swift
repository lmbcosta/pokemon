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
    private var _desc: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._podedexId = pokedexId
        self._pokemonURL = URL_BASE_POKEMON + "\(self.pokedex)"
    }
    
    var nextEvolutionName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    var desc: String {
        if _desc == nil {
            _desc = ""
        }
        return _desc
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
                    
                    // Get types
                    if let types = json["types"] as? [Dictionary<String, String>] , types.count > 0 {
                        if let name = types[0]["name"] {
                            self._type = name.capitalized
                        }
                        
                        // Check if there is more than one type
                        if types.count > 1 {
                            for x in 1..<types.count {
                                if let name = types[x]["name"] {
                                    self._type! += "/\(name.capitalized)"
                                    print(self._type)
                                }
                            }
                        }
                        
                    } else {
                        self._type = "quaqua"
                    }
                    
                    // Get description
                    if let descArray = json["descriptions"] as? [Dictionary<String, Any>], descArray.count > 0 {
                        if let descURL = descArray[0]["resource_uri"] as? String {
                            let path = URL_BASE + descURL
                            
                            if let url = URL(string: path) {
                                Alamofire.request(url).responseJSON{response in
                                    if let jsonDesc = response.result.value as? Dictionary<String, Any> {
                                        if let description = jsonDesc["description"] as? String {
                                            
                                            let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                            
                                            print(newDescription)
                                            self._desc = newDescription.capitalized     
                                        }
                                    }
                                    completed()
                                }
                            }
                            
                        }
                    } else {
                        self._desc = ""
                    }
                    
                    // Get evolutions
                    if let evolutions = json["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0 {
                        if let nextEvo = evolutions[0]["to"] as? String {
                            if nextEvo.range(of: "mega") == nil {
                                self._nextEvoName = nextEvo
                                print("Name: " + nextEvo)
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    let newString = uri.replacingOccurrences(of: "api/v1/pokemon/", with: "")
                                    let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                                    
                                    self._nextEvoId = nextEvoId
                                    print("Id: " + nextEvoId)
                                    
                                    if let levelExist = evolutions[0]["level"] {
                                        if let level = levelExist as? Int {
                                            self._nextEvoLevel = "\(level)"
                                        }
                                    } else {
                                        self._nextEvoLevel = ""
                                    }
                                }
                            }
                        }
                    }
                }
                completed()
            }
        }
    }
}
