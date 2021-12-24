import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var fetchingActivityIndicatorView: UIActivityIndicatorView!

    override func prepareForReuse() {
        pokemonImageView.image = nil

    }
    
    func configure(with pokemon: Species) {
        fetchingActivityIndicatorView.hidesWhenStopped = true
        fetchingActivityIndicatorView.startAnimating()
        let favorite = StorageManager.shared.fetchPokemon()
        if let _ = favorite.firstIndex(of: pokemon) {
            self.backgroundColor = .cyan
            self.layer.cornerRadius = 15
            self.layer.borderColor = CGColor(gray: 1, alpha: 0.3)
            self.layer.borderWidth = 2
        }

        pokemonNameLabel.text = pokemon.pokemonSpecies.name.capitalized
        pokemonImageView.fetchImage(from: pokemon.pokemonSpecies.imageUrl)
        fetchingActivityIndicatorView.stopAnimating()
    }
}

