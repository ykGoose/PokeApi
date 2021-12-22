import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet var pokemonImageView: ImageView!
    var pokemon: Species!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pokemon.pokemonSpecies.name.capitalized
        
        pokemonImageView.fetchImage(from: pokemon.pokemonSpecies.imageUrl)
    }
}

