import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var pokemonImageView: ImageView!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var fetchingActivityIndicatorView: UIActivityIndicatorView!
 
    
    override func prepareForReuse() {
        pokemonImageView.image = nil
    }
    
    func configure(with pokemon: Species?) {
        fetchingActivityIndicatorView.hidesWhenStopped = true
        fetchingActivityIndicatorView.startAnimating()
        pokemonNameLabel.text = pokemon?.pokemonSpecies.name.capitalized
        pokemonImageView.fetchImage(from: pokemon?.pokemonSpecies.imageUrl)
        fetchingActivityIndicatorView.stopAnimating()
    }
}

