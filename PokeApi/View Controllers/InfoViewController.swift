import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet var favoriteButton: UIBarButtonItem!
    @IBOutlet var pokemonImageView: UIImageView!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pokemon.pokemonSpecies.name.capitalized
        markButton()
        pokemonImageView.fetchImage(from: pokemon.pokemonSpecies.imageUrl)
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        if checkFavorite() {
            StorageManager.shared.delete(pokemon: pokemon)
            markButton()
        } else {
            StorageManager.shared.save(pokemon: pokemon)
            markButton()
        }
    }
    
    func checkFavorite() -> Bool {
        let pokemons = StorageManager.shared.fetchPokemon()
        guard let _ = pokemons.firstIndex(of: pokemon) else { return false }
        return true
    }
    
    func markButton() {
        if checkFavorite() {
            favoriteButton.image = UIImage(systemName: "star.fill")
        } else {
            favoriteButton.image = UIImage(systemName: "star")
        }
    }
}

