//
//  ViewController.swift
//  Pokemon
//
//  Created by Luis  Costa on 02/03/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectioView: UICollectionView!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var muteBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var filterPokemons: [Pokemon] = []
    var isInFilterMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collectioView.delegate = self
        collectioView.dataSource = self
        // To use search bar we need to use the protocol
        searchBar.delegate = self
        parsePokemonCSV()
        initAudio()
        
        // Search bar: Search button is done
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    func initAudio() {
        if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                musicPlayer.prepareToPlay()
                musicPlayer.numberOfLoops = -1
                musicPlayer.volume = 0.2
                musicPlayer.play()
                
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
    }

    func parsePokemonCSV() {
        if let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                
                for row in rows {
                    let id = Int(row["id"]!)
                    let name = row["identifier"]
                    let pokemon = Pokemon(name: name!, pokedexId: id!)
                    
                    // Apend to our pokemon array
                    pokemons.append(pokemon)
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
        
    }
    // Collection View protocol functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInFilterMode ? filterPokemons.count : pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
            let pokeArray = isInFilterMode ? filterPokemons : pokemons
            cell.configureCell(pokeArray[indexPath.row])
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    // Searchbar delegate procol function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let search = searchBar.text, search != "" {
            isInFilterMode = true
            let lowerSearch = search.lowercased()
            // Filer: pokemons that their name contains subsequences equal to filters
            filterPokemons = pokemons.filter({$0.name.range(of: lowerSearch) != nil})
            // reloaad view with searched data
            collectioView.reloadData()
        } else {
            isInFilterMode = false
            collectioView.reloadData()
            view.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    @IBAction func musicBtnPressed(_ sender: Any) {
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            volumeSlider.value = 0.0
            
            muteBtn.alpha = 0.5
        } else {
            musicPlayer.play()
            musicPlayer.volume = 0.5
            volumeSlider.value = 0.5
            muteBtn.alpha = 1
        }
    }
    
    @IBAction func volumeBtnPressed(_ sender: Any) {
        musicPlayer.volume = volumeSlider.value
        if musicPlayer.volume == 0.0 {
            musicPlayer.stop()
            muteBtn.alpha = 0.5
        } else {
            muteBtn.alpha = 1
            if !musicPlayer.isPlaying {
                musicPlayer.play()
            }
        }
    }
}

